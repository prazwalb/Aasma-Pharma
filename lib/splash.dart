import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkAuthenticationAndNavigate();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  Future<void> _checkAuthenticationAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    //
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: PColors.primaryColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(gradient: PColors.linearGradient),
        child: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: CustomPaint(painter: BackgroundPatternPainter()),
            ),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: PColors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: PColors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.local_pharmacy,
                              size: 60,
                              color: PColors.primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // App Name
                  Text(
                    PTexts.onBoardingSubTitle1,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: PColors.white,
                      letterSpacing: 1.2,
                    ),
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),

                  const SizedBox(height: 12),

                  // App Description
                  Text(
                    PTexts.onBoardingSubTitle1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: PColors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3),

                  const SizedBox(height: 80),

                  // Loading Indicator
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(PColors.white),
                    ),
                  ).animate().fadeIn(delay: 1200.ms),
                ],
              ),
            ),

            // Version Info
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('version 2')],
              ),
              //   'Version ${AppConstants.appVersion}',
              //   style: const TextStyle(
              //     color: PColors.white,
              //     fontSize: 12,
              //     fontWeight: FontWeight.w300,
              //   ),
              //   textAlign: TextAlign.center,
              // ).animate().fadeIn(delay: 1000.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PColors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw decorative circles
    for (int i = 0; i < 5; i++) {
      final radius = (i + 1) * 30.0;
      final center = Offset(
        size.width * 0.2 + (i * size.width * 0.15),
        size.height * 0.15 + (i * 20),
      );

      canvas.drawCircle(center, radius, paint);
    }

    // Draw cross pattern (medical symbol)
    final crossPaint = Paint()
      ..color = PColors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final crossSize = 20.0;
    for (int i = 0; i < 8; i++) {
      final x = (i * size.width / 7) + crossSize;
      final y = size.height * 0.8;

      // Vertical line
      canvas.drawRect(
        Rect.fromLTWH(x - 2, y - crossSize, 4, crossSize * 2),
        crossPaint,
      );

      // Horizontal line
      canvas.drawRect(
        Rect.fromLTWH(x - crossSize, y - 2, crossSize * 2, 4),
        crossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
