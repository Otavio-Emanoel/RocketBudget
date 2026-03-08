import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/animated_astro_rocket.dart';
import '../../core/providers/journey_provider.dart';
import 'widgets/add_transaction_modal.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddTransactionModal(),
          );
        },
        backgroundColor: AppColors.neonBlue,
        child: const Icon(Icons.add_rounded, color: AppColors.backgroundDark, size: 28),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.neonBlue.withOpacity(0.5), width: 2),
                          image: const DecorationImage(
                            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCoiirvG9Dl6-fm8H1wdFi6Ww7tc5V38J6YjxTODGMQzf9v7rZqIYSon5xpKUUIyWiadZ5nZV47MbN-9P4LulPl7Qs9bfPqOdgIpIJMeYovP1IpQE73uxlQ4M7rpiER_jd5sWCA1-h8KxZmOaaGE0K2plzekV2ms6jnuBkmdhBYS7P4Bzeh_x4Fbrr8sasCcX-v4JOZ6eJoyPAiXBNunRq2DWeNtwIsNItE2M65si_TlN2ExTKHA2gxsor-iOJf3pajGJR7DAyVreeP'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back,', style: GoogleFonts.inter(color: Colors.white54, fontSize: 12)),
                          Text(provider.userName, style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.neonBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_rounded, color: AppColors.neonBlue, size: 20),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Mascot Area
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.neonBlue.withOpacity(0.05), Colors.transparent],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background glow
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.neonBlue.withOpacity(0.2),
                                  blurRadius: 40,
                                  spreadRadius: 20,
                                ),
                              ],
                            ),
                          ),
                          // Astro Image
                          const AnimatedAstroRocket(size: 180),
                          
                          // Badge
                          Positioned(
                            bottom: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.neonBlue.withOpacity(0.2),
                                border: Border.all(color: AppColors.neonBlue.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'LAUNCHPAD ACTIVE',
                                style: GoogleFonts.inter(
                                  color: AppColors.neonBlue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Fuel Tank Progress
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1a3a41).withOpacity(0.25), // Glass
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fuel Tank Progress', style: GoogleFonts.inter(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: '\$${provider.totalSaved.toStringAsFixed(2)} ', style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                        TextSpan(text: '/ \$${provider.goalAmount.toStringAsFixed(2)}', style: GoogleFonts.inter(color: Colors.white54, fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text('${(provider.progressPercentage * 100).toStringAsFixed(1)}%', style: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0f2023),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white.withOpacity(0.1)),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: provider.progressPercentage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.neonBlue,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.neonBlue.withOpacity(0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().scaleX(begin: 0, end: 1, duration: 1.seconds, curve: Curves.easeOutCubic, alignment: Alignment.centerLeft),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              '"Keep fueling! We\'re gaining escape velocity." — Astro',
                              style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

                    const SizedBox(height: 16),

                    // Countdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeBlock('${provider.daysRemaining}', 'Days'),
                        _buildTimeBlock('00', 'Hrs'),
                        _buildTimeBlock('00', 'Min'),
                        _buildTimeBlock('00', 'Sec'),
                      ],
                    ).animate().fadeIn(delay: 400.ms),
                    
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Remaining until ${provider.destination}',
                        style: GoogleFonts.inter(color: Colors.white54, fontSize: 12),
                      ),
                    ).animate().fadeIn(delay: 400.ms),

                    const SizedBox(height: 16),

                    // Exchange Rate Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1a3a41).withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                        image: DecorationImage(
                          image: const NetworkImage('https://www.transparenttextures.com/patterns/stardust.png'),
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Exchange Rate', style: GoogleFonts.inter(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('1 BRL', style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Icon(Icons.arrow_forward_rounded, color: AppColors.neonBlue, size: 16),
                                      ),
                                      Text('0.25 CAD', style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('LATEST', style: GoogleFonts.inter(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.neonBlue.withOpacity(0.1),
                              border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: AppColors.neonBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.smart_toy_rounded, color: AppColors.backgroundDark, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '"Rates are looking stable today! Want to Buy now?"',
                                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.neonBlue,
                                    foregroundColor: AppColors.backgroundDark,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    minimumSize: Size.zero,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text('BUY', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBlock(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1a3a41).withOpacity(0.25), // Glass
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                color: value == '120' ? AppColors.neonBlue : Colors.white, 
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white54, 
                fontSize: 10, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
