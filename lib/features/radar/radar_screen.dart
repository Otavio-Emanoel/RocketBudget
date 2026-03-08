import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/animated_astro_rocket.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

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
                      const Icon(Icons.rocket_launch_rounded, color: AppColors.neonBlue, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Radar',
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
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_rounded, color: AppColors.neonBlue, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.settings_rounded, color: AppColors.neonBlue, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Astro Mascot Section
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.neonBlue.withOpacity(0.2), Colors.transparent],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const AnimatedAstroRocket(size: 80),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Astro\'s Scan',
                                  style: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 18, fontWeight: FontWeight.bold),
                                ).animate().fadeIn(delay: 200.ms),
                                const SizedBox(height: 4),
                                Text(
                                  'Scanning global markets for the best CAD/USD entry points.',
                                  style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 12),
                                ).animate().fadeIn(delay: 300.ms),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 100.ms),

                    const SizedBox(height: 24),

                    // Interactive Currency Chart
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF173036).withOpacity(0.6), // Glass Panel
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.neonBlue.withOpacity(0.1)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CAD / USD', style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('0.7428', style: GoogleFonts.inter(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 6.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.trending_up_rounded, color: Colors.greenAccent, size: 14),
                                            const SizedBox(width: 4),
                                            Text('1.2%', style: GoogleFonts.inter(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundDark.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    _buildTimeToggle('7D', true),
                                    _buildTimeToggle('1M', false),
                                    _buildTimeToggle('1Y', false),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Placeholder for Custom Chart Graphic
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: CustomPaint(
                              painter: _LineChartPainter(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
                              return Text(
                                day.toUpperCase(),
                                style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w500),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                    const SizedBox(height: 24),

                    // Price Alert Setup
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                         color: const Color(0xFF173036).withOpacity(0.6), // Glass Panel
                         borderRadius: BorderRadius.circular(16),
                         border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.notifications_active_rounded, color: AppColors.neonBlue, size: 20),
                              const SizedBox(width: 8),
                              Text('Set Price Alert', style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('Target Rate (USD per 1 CAD)', style: GoogleFonts.inter(color: Colors.white54, fontSize: 12)),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
                            ),
                            child: TextField(
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: '0.7500',
                                hintStyle: GoogleFonts.inter(color: Colors.white38),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text('USD', style: GoogleFonts.inter(color: AppColors.neonBlue, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.neonBlue.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.neonBlue.withOpacity(0.1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.vibration_rounded, color: AppColors.neonBlue, size: 20),
                                    const SizedBox(width: 12),
                                    Text('Push Notification', style: GoogleFonts.inter(color: Colors.white, fontSize: 14)),
                                  ],
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (val) {},
                                  activeColor: AppColors.neonBlue,
                                  activeTrackColor: AppColors.neonBlue.withOpacity(0.3),
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: Colors.grey.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add_alert_rounded),
                              label: Text('Activate Alert', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.neonBlue,
                                foregroundColor: AppColors.backgroundDark,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),

                    const SizedBox(height: 16),

                    // Market Sentiment Cards
                    Row(
                      children: [
                        _buildSentimentCard('Sentiment', 'Bullish', Colors.greenAccent),
                        const SizedBox(width: 16),
                        _buildSentimentCard('Volatility', 'Medium', AppColors.neonBlue),
                      ],
                    ).animate().fadeIn(delay: 600.ms),

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

  Widget _buildTimeToggle(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.neonBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isActive ? AppColors.backgroundDark : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSentimentCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF173036).withOpacity(0.6), // Glass Panel
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neonBlue.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(title.toUpperCase(), style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.inter(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the Graph Simulation
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = AppColors.neonBlue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.6, size.width * 0.4, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.9, size.width * 0.8, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.2, size.width, size.height * 0.1);

    // Gradient Fill under the line
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.neonBlue.withOpacity(0.3), AppColors.neonBlue.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paintLine);

    // Current Price Dot
    final dotPaint = Paint()..color = AppColors.neonBlue;
    final blurPaint = Paint()
      ..color = AppColors.neonBlue.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 8, blurPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
