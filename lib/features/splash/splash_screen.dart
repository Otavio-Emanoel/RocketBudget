import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
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
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => const WelcomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Background stars
          ...List.generate(30, (index) {
            return Positioned(
              left: (index * 25.0) % MediaQuery.of(context).size.width,
              top: (index * 45.0) % MediaQuery.of(context).size.height,
              child: Icon(
                Icons.star,
                size: (index % 3 == 0) ? 8 : 4,
                color: Colors.white.withOpacity(0.3),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .fadeIn(duration: 1.seconds, delay: (index * 100).ms)
                  .then()
                  .fadeOut(duration: 1.seconds),
            );
          }),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Astro Launching Animation
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonBlue.withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 10,
                      )
                    ],
                    gradient: const LinearGradient(
                      colors: [AppColors.cardDark, AppColors.backgroundDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    size: 80,
                    color: AppColors.neonBlue,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut)
                    .then()
                    .animate()
                    .scale(duration: 800.ms, curve: Curves.easeOutBack),
                    
                const SizedBox(height: 40),
                
                // App Title
                Text(
                  'RocketBudget',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    letterSpacing: 1.2,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 300.ms)
                    .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut),
                
                const SizedBox(height: 12),
                
                // Subtitle
                Text(
                  'A sua decolagem financeira para o mundo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 600.ms),
              ],
            ),
          ),
          
          // Progress indicating launching
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: Column(
              children: [
                Text(
                  'Preparando motores...',
                  style: GoogleFonts.inter(
                    color: AppColors.neonBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .fadeIn(duration: 800.ms),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.cardDark,
                    color: AppColors.neonBlue,
                    minHeight: 6,
                  )
                      .animate()
                      .custom(
                        duration: 3.seconds,
                        builder: (context, value, child) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: value,
                              backgroundColor: AppColors.cardDark,
                              color: AppColors.neonBlue,
                              minHeight: 6,
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
