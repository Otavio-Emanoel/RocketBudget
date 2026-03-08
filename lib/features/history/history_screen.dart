import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/animated_astro_rocket.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.history_rounded, color: AppColors.neonBlue, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'History',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.search_rounded, color: AppColors.neonBlue, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.filter_list_rounded, color: AppColors.neonBlue, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Mascot Saving Streak Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 160,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.neonBlue.withOpacity(0.3), AppColors.backgroundDark],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.neonBlue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.bolt_rounded, color: AppColors.neonBlue, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '7 DAY STREAK',
                                          style: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ).animate().fadeIn(delay: 200.ms),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Out of this world!',
                                    style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ).animate().fadeIn(delay: 300.ms).slideX(),
                                  const SizedBox(height: 4),
                                  Text(
                                    'You\'ve hit your savings goal every day this week.',
                                    style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 12, height: 1.3),
                                  ).animate().fadeIn(delay: 400.ms),
                                ],
                              ),
                            ),
                            // Astro Custom Rocket
                            const AnimatedAstroRocket(size: 100).animate().scale(delay: 500.ms, curve: Curves.easeOutBack),
                          ],
                        ),
                      ),
                    ),

                    // Monthly Breakdown
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Monthly Breakdown', style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('October 2024', style: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildBreakdownCard('TOTAL INCOME', '\$5,240.00', '+12%', true),
                              const SizedBox(width: 16),
                              _buildBreakdownCard('TOTAL SAVINGS', '\$1,120.50', '+5.2%', true),
                            ],
                          ),
                        ],
                      ).animate().fadeIn(delay: 600.ms),
                    ),

                    // Transaction List
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Transaction History', style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('View All', style: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildTransactionItem('Monthly Salary', 'Oct 28 • Rocket Corp', '+\$4,500.00', Icons.payments_rounded, Colors.green),
                          _buildTransactionItem('Freelance Project', 'Oct 25 • UI Design System', '+\$620.00', Icons.code_rounded, AppColors.neonBlue),
                          _buildTransactionItem('Birthday Gift', 'Oct 22 • From Family', '+\$120.00', Icons.card_giftcard_rounded, Colors.purpleAccent),
                          _buildTransactionItem('Market Groceries', 'Oct 20 • Fresh Mart', '-\$84.20', Icons.shopping_cart_rounded, Colors.redAccent, isExpense: true),
                        ],
                      ).animate().fadeIn(delay: 700.ms),
                    ),
                    
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

  Widget _buildBreakdownCard(String title, String amount, String diff, bool isPositive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1a3a41).withOpacity(0.25), // Glass
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            Text(amount, style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                  color: isPositive ? Colors.greenAccent : Colors.redAccent,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '$diff vs last month',
                  style: GoogleFonts.inter(color: isPositive ? Colors.greenAccent : Colors.redAccent, fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String subtitle, String amount, IconData icon, Color color, {bool isExpense = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a3a41).withOpacity(0.25), // Glass
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                  color: isExpense ? Colors.white : Colors.greenAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'CAD CONVERTED',
                style: GoogleFonts.inter(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
