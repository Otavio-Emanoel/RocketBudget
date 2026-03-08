import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with Astro Avatar
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.smart_toy_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  )
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.easeOutBack)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: -5, end: 5, duration: 2.seconds),
                ),
                const SizedBox(height: 32),

                // Greeting Texts
                Text(
                  'Olá! Eu sou o Astro 🚀',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
                
                const SizedBox(height: 12),
                
                Text(
                  'Criado por Antigravity (IA)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neonBlue,
                    letterSpacing: 1.1,
                  ),
                ).animate().fadeIn(delay: 500.ms),

                const SizedBox(height: 24),

                Text(
                  'Serei seu co-piloto e grande parceiro na sua próxima jornada internacional. Vou te ajudar a economizar com gamificação, inteligência e muito estilo!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ).animate().fadeIn(delay: 700.ms),

                const SizedBox(height: 48),

                // Features List
                _buildFeatureItem(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Clareza Absoluta',
                  description: 'Entenda seu progresso rapidamente.',
                  delay: 900,
                ),
                _buildFeatureItem(
                  icon: Icons.rocket_launch_rounded,
                  title: 'Motivação Diária',
                  description: 'Encha o tanque e veja seu dinheiro te levar mais longe.',
                  delay: 1100,
                ),
                _buildFeatureItem(
                  icon: Icons.palette_rounded,
                  title: 'Estética Premium',
                  description: 'Animações fluidas em uma interface dark moderna.',
                  delay: 1300,
                ),

                const SizedBox(height: 50),

                // Button
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to Setup Journey
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonBlue,
                    foregroundColor: AppColors.backgroundDark,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: AppColors.neonBlue.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Iniciar Jornada',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: 1600.ms)
                    .scale(delay: 1600.ms, curve: Curves.easeOutBack),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
            ),
            child: Icon(icon, color: AppColors.neonBlue, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1),
    );
  }
}
