import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../smart_tips/presentation/smart_tips_page.dart';
import '../../../app_theme.dart';
import '../../../shared/providers/offline_data_provider.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const String _dashboardTutorialSeenKey = 'dashboard_tutorial_seen_v1';
  int totalBirds = 0;
  int totalFeeds = 0;
  int totalEggs = 0;
  bool loading = true;
  String? userName;
  bool _tutorialChecked = false;

  // Tutorial keys for dashboard quick actions
  final GlobalKey _batchesKey = GlobalKey();
  final GlobalKey _reportsKey = GlobalKey();
  final GlobalKey _storeKey = GlobalKey();
  final GlobalKey _tipsKey = GlobalKey();
  final GlobalKey _summaryKey = GlobalKey();
  final GlobalKey _extensionKey = GlobalKey();

  TutorialCoachMark? _tutorialCoachMark;
  final List<TargetFocus> _targets = [];

  @override
  void initState() {
    super.initState();
    _fetchSummary();
  }

  Future<void> _fetchSummary() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        setState(() => loading = false);
        return;
      }
      // Load dashboard data with offline fallback - force refresh to get latest user name
      await OfflineDataProvider.instance.loadDashboardData(forceRefresh: true);

      final dashboardData = OfflineDataProvider.instance.dashboardData;

      setState(() {
        totalBirds = dashboardData?['totalBirds'] ?? 0;
        totalFeeds = dashboardData?['totalFeeds'] ?? 0;
        totalEggs = dashboardData?['totalEggs'] ?? 0;
        userName = dashboardData?['userName'] ?? 'type_here'.tr();
        loading = false;
      });

      if (!_tutorialChecked) {
        _tutorialChecked = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _maybeShowTutorial();
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      // Optionally, show a snackbar or error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('failed_to_load_summary'.tr(args: [e.toString()])),
          ),
        );
      }
    }
  }

  Future<void> _maybeShowTutorial() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenTutorial = prefs.getBool(_dashboardTutorialSeenKey) ?? false;
      // Debug log so we can see in console whether tutorial should run
      // ignore: avoid_print
      print(
        '[DashboardPage] Tutorial seen: $hasSeenTutorial (key: $_dashboardTutorialSeenKey)',
      );
      if (hasSeenTutorial) return;

      _showTutorial();
      await prefs.setBool(_dashboardTutorialSeenKey, true);
    } catch (_) {
      // If anything goes wrong, just skip the tutorial to avoid blocking UX
    }
  }

  void _showTutorial() {
    _targets.clear();

    // Build targets only for widgets that are actually laid out
    final candidateConfigs = [
      (
        id: 'batches',
        key: _batchesKey,
        align: ContentAlign.bottom,
        title: 'Chicken Batches',
        message:
            'Click here to add a new batch of birds or manage your existing ones. Think of it as your digital coop!',
      ),
      (
        id: 'reports',
        key: _reportsKey,
        align: ContentAlign.bottom,
        title: 'Farm Reports',
        message:
            'Log daily updates on growth and health here so you never miss a beat in your flock\'s performance.',
      ),
      (
        id: 'store',
        key: _storeKey,
        align: ContentAlign.top,
        title: 'Farm Store',
        message:
            'Keep track of your feeds, vaccines, and supplies to ensure you never run out of the essentials.',
      ),
      (
        id: 'tips',
        key: _tipsKey,
        align: ContentAlign.top,
        title: 'Smart Tips',
        message:
            'Browse short videos and articles packed with expert advice on better farm management and bird care.',
      ),
      (
        id: 'summary',
        key: _summaryKey,
        align: ContentAlign.top,
        title: 'Farm Summary',
        message:
            'Check this section for a clear view of your finances and a bird\'s-eye view of your overall progress.',
      ),
      (
        id: 'extension',
        key: _extensionKey,
        align: ContentAlign.top,
        title: 'Extension Service',
        message:
            'Find and contact local experts and extension officers nearby whenever you need an extra hand or professional advice.',
      ),
    ];

    int stepIndex = 0;
    for (final config in candidateConfigs) {
      if (config.key.currentContext == null) {
        // ignore: avoid_print
        print(
          '[DashboardPage] Tutorial target "${config.id}" has no context yet, skipping.',
        );
        continue;
      }

      final currentStep = stepIndex + 1;
      final totalSteps = candidateConfigs.length;

      _targets.add(
        TargetFocus(
          identify: config.id,
          keyTarget: config.key,
          contents: [
            TargetContent(
              align: config.align,
              child: _buildTutorialCard(
                title: config.title,
                message: config.message,
                currentStep: currentStep,
                totalSteps: totalSteps,
                onSkip: () {
                  _tutorialCoachMark?.finish();
                },
              ),
            ),
          ],
        ),
      );
      stepIndex++;
    }

    if (_targets.isEmpty) {
      // ignore: avoid_print
      print('[DashboardPage] No tutorial targets available, not showing tour.');
      return;
    }

    _tutorialCoachMark = TutorialCoachMark(
      targets: _targets,
      colorShadow: Colors.black.withOpacity(0.7),
      textSkip: 'Skip',
      paddingFocus: 8,
      opacityShadow: 0.8,
      onClickTargetWithTapPosition: (target, tapDetails) {
        // Allow skipping by tapping outside the card
        _tutorialCoachMark?.next();
      },
    );

    // Small delay to be extra sure layout is complete
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      _tutorialCoachMark?.show(context: context);
    });
  }

  Widget _buildTutorialCard({
    required String title,
    required String message,
    required int currentStep,
    required int totalSteps,
    required VoidCallback onSkip,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep - 1;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? 6 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: isCompleted || isCurrent
                        ? CustomColors.primary
                        : Colors.grey[300],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          // Step counter
          Text(
            'Step $currentStep of $totalSteps',
            style: TextStyle(
              fontSize: 12,
              color: CustomColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: CustomColors.text.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 16),
          // Buttons: Skip (left, grey text) and Continue (right, primary with arrow) as text buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onSkip,
                  style: TextButton.styleFrom(
                    foregroundColor: CustomColors.textDisabled,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'skip'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  onPressed: () => _tutorialCoachMark?.next(),
                  style: TextButton.styleFrom(
                    foregroundColor: CustomColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'continue'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: CustomColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget quickAction(
      BuildContext context,
      String label,
      Widget icon,
      String route, {
      bool isComingSoon = false,
      GlobalKey? targetKey,
    }) {
      return Material(
        key: targetKey,
        color: Colors.transparent, // Remove yellow background
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            if (route == '/smart-tips') {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SmartTipsPage()));
            } else if (isComingSoon) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('coming_soon'.tr()),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              context.go(route);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35, // Bigger circle
                  backgroundColor: CustomColors.secondary,
                  child: SizedBox(width: 45, height: 45, child: icon),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
        title: Text(
          'dashboard'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        // Removed notification icon from actions
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Prevent overflow
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'welcome_back'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      userName != null ? userName! : 'type_here'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 350,
                      height: 117,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x1400681D),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/animal-chicken.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'birds'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomColors.text,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                totalBirds.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: CustomColors.text,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/feeds.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'feeds'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomColors.text,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${totalFeeds}kgs',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: CustomColors.text,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/eggs-f.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'eggs'.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomColors.text,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                totalEggs.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: CustomColors.text,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Text(
                      'quick_actions'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.3,
                        children: [
                          quickAction(
                            context,
                            'add_chick_batch'.tr(),
                            SvgPicture.asset(
                              'assets/icons/add-batch.svg',
                              width: 40,
                              height: 40,
                            ),
                            '/batches',
                            targetKey: _batchesKey,
                          ),
                          quickAction(
                            context,
                            'farm_report'.tr(),
                            SvgPicture.asset(
                              'assets/icons/reportv3.svg',
                              width: 40,
                              height: 40,
                            ),
                            '/reports',
                            targetKey: _reportsKey,
                          ),
                          quickAction(
                            context,
                            'farm_store'.tr(),
                            SvgPicture.asset(
                              'assets/icons/storev2.svg',
                              width: 40,
                              height: 40,
                            ),
                            '/inventory',
                            targetKey: _storeKey,
                          ),
                          quickAction(
                            context,
                            'financial_summary'.tr(),
                            SvgPicture.asset(
                              'assets/icons/money.svg',
                              width: 35,
                              height: 35,
                            ),
                            '/farm-summary',
                            targetKey: _summaryKey,
                          ),
                          quickAction(
                            context,
                            'smart_tips'.tr(),
                            Icon(
                              Icons.lightbulb,
                              color: CustomColors.text,
                              size: 36,
                            ),
                            '/smart-tips',
                            targetKey: _tipsKey,
                          ),
                          quickAction(
                            context,
                            'extension_service'.tr(),
                            SvgPicture.asset(
                              'assets/icons/extensionv2.svg',
                              width: 35,
                              height: 35,
                            ),
                            '/#',
                            isComingSoon: true,
                            targetKey: _extensionKey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
