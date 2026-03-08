import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  Text(
                    'Settings',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.neonBlue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.neonBlue, width: 2),
                                      image: const DecorationImage(
                                        image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDtrx4yDlnoDueiovo6MM4vKUNvzhqq5BCmLTuOWmvSmz_EfM0lgJE1Yo9XFnQStGzygUMFrltEGC3o6TeZya7D4BenlTvqXBm0pA6bdx4QmNE6jCejUQ3NtfX7QbwfWaaHZS95ANrqJqRQAHjw6t2qqpC1DE9198Bl2yL878c9_ORmKcoNR-4diOPAwSmoNUmjdTHs6TzW5bzhhc35dwqE8h9tbhPY09djtiBQNx5OyObac3kHbjk2dh1_LUXJ0xAKz8liTG7JKPXD'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColors.neonBlue,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.backgroundDark, width: 2),
                                      ),
                                      child: const Icon(Icons.verified_rounded, color: AppColors.backgroundDark, size: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Commander Alex', style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text('alex@rocketbudget.space', style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 14, fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.neonBlue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text('Pro Member', style: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.neonBlue,
                                foregroundColor: AppColors.backgroundDark,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Edit Profile', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 100.ms),

                    const SizedBox(height: 24),

                    // Journey Setup Card
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Opacity(
                              opacity: 0.8,
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuA0W1wbazrBRdZM97JjReDatQCZcdl9RfO2npmC1H1PvtH-q828yNHNbbxj65Swuy7frNAre_PXSLLIFmFtDkIFdvSvNuDAhmLcp01OrcZgsc9tAv-q_p67L-NR2Vi6aW7J4CZ1BIhE45YPCrh8c-OAXfr_BzwImyTNjYuT6H5ICZu4SN9Do5qWZM9YB0-ANxOf_koyKgYBP3mAjFslq3pBgBI53Miy3GB04txQfbx0lIE8b-VartZmwsgBSRHnwkt5O7H5pqzK4_rT',
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.rocket_launch_rounded, color: AppColors.neonBlue, size: 20),
                                    const SizedBox(width: 8),
                                    Text('Journey Setup', style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _buildJourneyRow(Icons.calendar_month_rounded, 'TRIP DATE', 'Oct 12 - Oct 20, 2024'),
                                _buildJourneyRow(Icons.location_on_rounded, 'DESTINATION', 'Mars Colony Prime'),
                                _buildJourneyRow(Icons.savings_rounded, 'TARGET GOAL', '\$25,000.00 Credits'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

                    const SizedBox(height: 24),

                    // Preferences header
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        'PREFERENCES',
                        style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ).animate().fadeIn(delay: 300.ms),

                    // Preferences List
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDarker,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Column(
                        children: [
                          _buildPreferenceItem(Icons.payments_rounded, 'Currency', 'USD (\$) - US Dollar'),
                          Divider(color: Colors.white.withOpacity(0.05), height: 1),
                          _buildPreferenceItem(Icons.military_tech_rounded, 'Achievements', '12 badges unlocked'),
                          Divider(color: Colors.white.withOpacity(0.05), height: 1),
                          _buildPreferenceItem(Icons.security_rounded, 'Security', 'Two-factor enabled'),
                        ],
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                    const SizedBox(height: 24),

                    // Logout Button
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
                      ),
                      child: ListTile(
                        onTap: () {},
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                        ),
                        title: Text('Log Out', style: GoogleFonts.inter(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      ),
                    ).animate().fadeIn(delay: 500.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF94a3b8), size: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: GoogleFonts.inter(color: const Color(0xFF64748b), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 2),
                  Text(value, style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF94a3b8)),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(IconData icon, String title, String subtitle) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.neonBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.neonBlue),
      ),
      title: Text(title, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94a3b8)),
    );
  }
}
