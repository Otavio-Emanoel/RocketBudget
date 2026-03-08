import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundDark, Color(0xFF1a3a41), AppColors.backgroundDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Spacer for top
              const SizedBox(height: 20),
              
              // App Bar / Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.rocket_launch_rounded, color: AppColors.neonBlue),
                        const SizedBox(width: 8),
                        Text(
                          'RocketBudget',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.question_mark_rounded, color: Colors.white70, size: 16),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms),

              // Central Image Area
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glow
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neonBlue.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neonBlue.withOpacity(0.2),
                              blurRadius: 60,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      // Square Card Effect behind Astronaut
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 280,
                          height: 280,
                          color: Colors.black.withOpacity(0.3),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/astro_3d.png',
                                width: 220,
                                height: 220,
                                fit: BoxFit.contain,
                              )
                                  .animate(onPlay: (c) => c.repeat(reverse: true))
                                  .moveY(begin: -8, end: 8, duration: 3.seconds, curve: Curves.easeInOut),
                            ],
                          ),
                        ),
                      ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
                      
                      // Decorative side ring
                      Positioned(
                        right: -40,
                        child: Icon(
                          Icons.radar,
                          size: 150,
                          color: AppColors.neonBlue.withOpacity(0.1),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Bottom Texts and Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  children: [
                    Text(
                      'Sua Jornada',
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
                    Text(
                      'Começa Aqui',
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neonBlue,
                        letterSpacing: -1,
                        shadows: [
                          BoxShadow(
                            color: AppColors.neonBlue.withOpacity(0.5),
                            blurRadius: 20,
                          )
                        ]
                      ),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'Transforme seu sonho de intercâmbio em realidade com economia inteligente e gamificada.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: const Color(0xFF94a3b8),
                        height: 1.5,
                      ),
                    ).animate().fadeIn(delay: 700.ms),
                    
                    const SizedBox(height: 48),

                    // Começar Button
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonBlue.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 500),
                              pageBuilder: (_, __, ___) => const OnboardingScreen(),
                              transitionsBuilder: (_, animation, __, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  )),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.neonBlue,
                          foregroundColor: AppColors.backgroundDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Começar Configuração',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 900.ms).scale(curve: Curves.easeOutBack),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Leva apenas 2 minutos para decolar',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF64748b),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(delay: 1100.ms),
                    
                    const SizedBox(height: 24),
                    
                    // Small indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 30, height: 4, decoration: BoxDecoration(color: AppColors.neonBlue, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 6),
                        Container(width: 8, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 6),
                        Container(width: 8, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                      ],
                    ).animate().fadeIn(delay: 1200.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
