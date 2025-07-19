import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_theme.dart';
import 'dart:ui'; // Added for BackdropFilter

class OnboardingPage extends StatefulWidget {
  final VoidCallback onFinish;
  const OnboardingPage({super.key, required this.onFinish});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingScreenData> _screens = [
    _OnboardingScreenData(
      image: 'assets/icons/onboarding-image-1.png',
      title: 'Manage Your Poultry Farm',
      description: 'Track, manage, and grow your farm with ease.',
    ),
    _OnboardingScreenData(
      image: 'assets/icons/onboarding-image-2.png',
      title: 'Never Miss a Schedule',
      description:
          'Get reminders for vaccinatons and feeding stages to ensure your kukus are healthy.',
    ),
    _OnboardingScreenData(
      image: 'assets/icons/onboarding-image-3.png',
      title: 'Farm Smart',
      description:
          'Keep your important records in one place and only one tap away.',
    ),
  ];

  void _onNext() async {
    if (_currentPage < _screens.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_complete', true);
      widget.onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image fills the whole page
            PageView.builder(
              controller: _controller,
              itemCount: _screens.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final data = _screens[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(data.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            // Overlay container with blurry top edge at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                ),
                decoration: BoxDecoration(
                  gradient: (_currentPage == 0)
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors.lightGreen.withOpacity(0.0),
                            CustomColors.lightGreen.withOpacity(0.95),
                            CustomColors.lightGreen.withOpacity(1.0),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        )
                      : (_currentPage == 1)
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors.secondary.withOpacity(0.0),
                            CustomColors.secondary.withOpacity(0.95),
                            CustomColors.secondary.withOpacity(1.0),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        )
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors.primary.withOpacity(0.0),
                            CustomColors.primary.withOpacity(0.7),
                            CustomColors.primary.withOpacity(1.0),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                ),
                child: SafeArea(
                  bottom: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Dots at the top
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_screens.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? CustomColors.secondary
                                    : Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                        const Spacer(),
                        // Title and description at the bottom
                        Text(
                          _screens[_currentPage].title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: _currentPage == 0
                                    ? CustomColors.text
                                    : _currentPage == 1
                                    ? CustomColors.text
                                    : _currentPage == 2
                                    ? CustomColors.lightYellow
                                    : Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.normal,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _screens[_currentPage].description,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: _currentPage == 0
                                    ? CustomColors.text
                                    : _currentPage == 1
                                    ? CustomColors.text
                                    : _currentPage == 2
                                    ? CustomColors.lightYellow
                                    : Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_currentPage != 2) ...[
                              TextButton(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool(
                                    'onboarding_complete',
                                    true,
                                  );
                                  widget.onFinish();
                                },
                                child: Text(
                                  'Skip',
                                  style: TextStyle(color: CustomColors.text),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    (_currentPage == 0 || _currentPage == 1)
                                    ? CustomColors.primary
                                    : Colors.white.withOpacity(0.18),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color:
                                        (_currentPage == 0 || _currentPage == 1)
                                        ? Colors.white
                                        : CustomColors.text,
                                  ),
                                  onPressed: _onNext,
                                ),
                              ),
                            ] else ...[
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: CustomColors.buttonGradient,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool(
                                        'onboarding_complete',
                                        true,
                                      );
                                      widget.onFinish();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      foregroundColor: CustomColors.text,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    child: Text(
                                      'CONTINUE',
                                      style: TextStyle(
                                        color: CustomColors.text,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingScreenData {
  final String image;
  final String title;
  final String description;
  const _OnboardingScreenData({
    required this.image,
    required this.title,
    required this.description,
  });
}
