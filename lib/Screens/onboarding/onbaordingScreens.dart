import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/custom_button.dart';

class _OnboardData {
  final String image;
  final String titleTop;
  final String titleBottom;
  final String description;

  const _OnboardData({
    required this.image,
    required this.titleTop,
    required this.titleBottom,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  // Illustrations ke asset aane tak icons placeholder hain.
  static const _pages = [
    _OnboardData(
      image: "assets/images/onboarding1-r.png",
      titleTop: 'Get Real',
      titleBottom: 'Followers',
      description: 'Grow your TikTok account with\nreal and active followers.',
    ),
    _OnboardData(
      image: "assets/images/onboarding2.png",
      titleTop: 'Boost Your',
      titleBottom: 'Likes & Views',
      description: 'Get more likes, views and\nengagement on your videos.',
    ),
    _OnboardData(
      image: "assets/images/onboarding3.png",
      titleTop: 'Track Your',
      titleBottom: 'Progress',
      description: 'See your growth and reach\nyour goals step by step.',
    ),
  ];

  bool get _isLast => _index == _pages.length - 1;

  void _goToLogin() =>
      Navigator.pushReplacementNamed(context, AppRoutes.login);

  void _next() {
    if (_isLast) {
      _goToLogin();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 4),
                child: AnimatedOpacity(
                  opacity: _isLast ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: TextButton(
                    onPressed: _isLast ? null : _goToLogin,
                    child: const Text('Skip'),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                              child: Center(
                                child: Image.asset(
                                  p.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                        Text(
                          p.titleTop,
                          style: textTheme.headlineLarge?.copyWith(
                            fontSize: 34,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          p.titleBottom,
                          style: textTheme.headlineLarge?.copyWith(
                            fontSize: 34,
                            color: AppColors.primary,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(p.description, style: textTheme.bodyMedium?.copyWith(
                          fontSize: 17,
                          height: 1.5
                        )),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots
            SmoothPageIndicator(
              controller: _controller,
              count: _pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
                activeDotColor: AppColors.primary,
                dotColor: AppColors.border,
              ),
            ),
            const SizedBox(height: 24),

            // Button
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
              child: CustomButton(
                text: _isLast ? 'Get Started' : 'Next',
                icon: Icons.arrow_forward_rounded,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}