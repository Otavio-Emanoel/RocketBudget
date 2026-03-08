import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import '../history/history_screen.dart';
import '../radar/radar_screen.dart';
import '../settings/settings_screen.dart';
import '../../core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RadarScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF173036).withOpacity(0.6), // Glass panel color from radar
          border: Border(
            top: BorderSide(
              color: AppColors.neonBlue.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(0, Icons.home_filled, Icons.home_outlined, 'Home'),
                _buildNavItem(1, Icons.track_changes_rounded, Icons.track_changes_outlined, 'Radar'),
                
                // Central FAB (+ Button)
                GestureDetector(
                  onTap: () {
                    // TODO: Open Action Menu / Add transaction
                  },
                  child: Container(
                    height: 56,
                    width: 56,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.neonBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColors.backgroundDark,
                      size: 32,
                    ),
                  ),
                ),
                
                _buildNavItem(2, Icons.history_rounded, Icons.history_outlined, 'History'),
                _buildNavItem(3, Icons.settings_rounded, Icons.settings_outlined, 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? AppColors.neonBlue : Colors.white54,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.neonBlue : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
