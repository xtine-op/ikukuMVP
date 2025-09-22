import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../../../shared/providers/offline_data_provider.dart';
import '../../../shared/services/connectivity_manager.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int totalBirds = 0;
  int totalFeeds = 0;
  int totalEggs = 0;
  bool loading = true;
  String? userName;
  int _selectedIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Home: stay on dashboard
        break;
      case 1:
        context.go('/profile');
        break;
      case 2:
        context.go('/inventory');
        break;
    }
  }

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
      // Load dashboard data with offline fallback
      await OfflineDataProvider.instance.loadDashboardData();

      final dashboardData = OfflineDataProvider.instance.dashboardData;

      String? fullName;
      try {
        final userResponse = await Supabase.instance.client
            .from('users')
            .select('full_name')
            .eq('id', user.id)
            .maybeSingle();
        fullName = userResponse?['full_name'];
      } catch (_) {
        fullName = null;
      }

      setState(() {
        totalBirds = dashboardData?['totalBirds'] ?? 0;
        totalFeeds = dashboardData?['totalFeeds'] ?? 0;
        totalEggs = dashboardData?['totalEggs'] ?? 0;
        userName = (fullName != null && fullName.trim().isNotEmpty)
            ? fullName.split(' ').first
            : (user.userMetadata?['full_name'] != null &&
                  (user.userMetadata?['full_name'] as String).trim().isNotEmpty)
            ? (user.userMetadata?['full_name'] as String).split(' ').first
            : (user.email?.split('@').first ?? 'type_here'.tr());
        loading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    Widget summaryItem(String label, String value) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: CustomColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14, color: CustomColors.text)),
        ],
      );
    }

    Widget quickAction(
      BuildContext context,
      String label,
      Widget icon,
      String route, {
      bool isComingSoon = false,
    }) {
      return Material(
        color: Colors.transparent, // Remove yellow background
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            if (isComingSoon) {
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
                  radius: 30, // Slightly reduced circle
                  backgroundColor: CustomColors.secondary,
                  child: SizedBox(width: 30, height: 30, child: icon),
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
                            'farm_report'.tr(),
                            SvgPicture.asset(
                              'assets/icons/farm-report.svg',
                              width: 36,
                              height: 36,
                            ),
                            '/reports',
                          ),
                          quickAction(
                            context,
                            'farm_store'.tr(),
                            SvgPicture.asset(
                              'assets/icons/farm-store.svg',
                              width: 36,
                              height: 36,
                            ),
                            '/inventory',
                          ),

                          quickAction(
                            context,
                            'add_chick_batch'.tr(),
                            SvgPicture.asset(
                              'assets/icons/add-batch.svg',
                              width: 36,
                              height: 36,
                            ),
                            '/batches',
                          ),
                          quickAction(
                            context,
                            'request_farm_summary'.tr(),
                            SvgPicture.asset(
                              'assets/icons/Request-farm-summary.svg',
                              width: 36,
                              height: 36,
                            ),
                            '/#',
                            isComingSoon: true,
                          ),
                          quickAction(
                            context,
                            'extension_service'.tr(),
                            SvgPicture.asset(
                              'assets/icons/extension-farmers.svg',
                              width: 36,
                              height: 36,
                            ),
                            '/#',
                            isComingSoon: true,
                          ),
                          quickAction(
                            context,
                            'smart_tips'.tr(),
                            Icon(
                              Icons.lightbulb,
                              color: CustomColors.text,
                              size: 36,
                            ),
                            '/#',
                            isComingSoon: true,
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
