import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  Future<void> _navigateToWelcome() async {
    // Simulate loading time (e.g. 5 seconds for full progress effect)
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (_, __, ___) => const WelcomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00d4ff);
    const bgDark = Color(0xFF0f2023);
    const bgMid = Color(0xFF1a3a41);

    return Scaffold(
      backgroundColor: bgDark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [bgDark, bgMid, bgDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Star field background
            const Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: StarFieldWidget(),
              ),
            ),
            
            // Central glow for the rocket
            Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.15),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),

            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20), // Top spacing

                  // Rocket + Typography Center
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 3D Rocket Mascot
                        SizedBox(
                          width: 260,
                          height: 260,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Subtle background blur disk under rocket
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor.withOpacity(0.2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 50,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                              // Rocket image
                              Image.asset(
                                'assets/images/astro_3d.png',
                                fit: BoxFit.contain,
                              )
                                  .animate(onPlay: (c) => c.repeat(reverse: true))
                                  .moveY(begin: -15, end: 15, duration: 2500.ms, curve: Curves.easeInOutSine),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 48),

                        // Title: RocketBudget
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            children: const [
                              TextSpan(
                                text: 'Rocket',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: 'Budget',
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, curve: Curves.easeOut),

                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          'Sua decolagem financeira para o mundo',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF94a3b8), // slate-400
                            height: 1.2,
                          ),
                        ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
                      ],
                    ),
                  ),

                  // Bottom Glass Card Progress Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // "Preparando motores..." Row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.settings_input_component_rounded,
                                        color: primaryColor,
                                        size: 16,
                                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                                       .fade(begin: 0.4, end: 1.0, duration: 800.ms),
                                      const SizedBox(width: 8),
                                      Text(
                                        'PREPARANDO MOTORES...',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 0.0, end: 100.0),
                                    duration: const Duration(seconds: 4),
                                    builder: (context, value, child) {
                                      return Text(
                                        '${value.toInt()}%',
                                        style: GoogleFonts.jetBrainsMono(
                                          color: primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              
                              // Stylized Progress Bar (Striped)
                              Container(
                                height: 12,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1e293b).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(seconds: 4),
                                  curve: Curves.easeInOutQuad,
                                  builder: (context, value, child) {
                                    return FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x8000d4ff),
                                              blurRadius: 15,
                                            )
                                          ],
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0x9900d4ff), 
                                              primaryColor
                                            ],
                                          ),
                                        ),
                                        // A simple internal hatch pattern could be added here for extra style
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),

                              // "Fuel System: Optimal" Footer
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'FUEL SYSTEM: OPTIMAL',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF64748b), // slate-500
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: primaryColor,
                                              blurRadius: 5,
                                            )
                                          ]
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.3),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.3),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideY(begin: 0.1),
                  ),
                  
                  // Powered By Footer
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      'POWERED BY FINANCIAL PROPULSION SYSTEMS',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569), // slate-600
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the Stars Background
class StarFieldWidget extends StatelessWidget {
  const StarFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarFieldPainter(),
      size: Size.infinite,
    );
  }
}

class StarFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rand = Random(42); // Fixed seed for stable stars
    final paintWhite = Paint()..color = Colors.white;
    final paintCyan = Paint()..color = const Color(0xFF00d4ff);

    for (int i = 0; i < 150; i++) {
      final x = rand.nextDouble() * size.width;
      final y = rand.nextDouble() * size.height;
      final isCyan = rand.nextDouble() > 0.9;
      final radius = rand.nextDouble() * 1.5 + 0.5;

      canvas.drawCircle(Offset(x, y), radius, isCyan ? paintCyan : paintWhite);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
