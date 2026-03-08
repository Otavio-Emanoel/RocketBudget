import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import 'steps/step_currencies.dart';
import 'steps/step_date_goal.dart';
import 'steps/step_destination.dart';
import 'steps/step_name.dart';
import '../main/main_layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  // Global state to collect data
  String _userName = '';
  String _destination = '';
  DateTime? _travelDate;
  double _goalAmount = 0.0;
  List<String> _monitoredCurrencies = ['USD']; // default

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context); // Go back to welcome
    }
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    
    if (!mounted) return;
    
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const MainLayoutScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar / Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onPressed: _previousPage,
                  ),
                  Text(
                    'Onboarding',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (_currentPage == _totalPages - 1)
                    const Icon(Icons.rocket_launch_rounded, color: AppColors.neonBlue)
                  else
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                ],
              ),
            ),
            
            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text indicator if needed (like "Trip Planning") or just the bar
                  if (_currentPage == 2)
                    Text('Trip Planning', style: GoogleFonts.inter(color: Colors.white, fontSize: 12))
                  else
                    const SizedBox(),
                  
                  Text(
                    '${_currentPage + 1} de $_totalPages',
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentPage + 1) / _totalPages,
                  backgroundColor: AppColors.cardDark,
                  color: AppColors.neonBlue,
                  minHeight: 4,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pages
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  StepName(
                    onNameChanged: (val) => _userName = val,
                    onNext: _nextPage,
                    initialName: _userName,
                  ),
                  StepDestination(
                    onDestinationChanged: (val) => _destination = val,
                    onNext: _nextPage,
                    initialDestination: _destination,
                  ),
                  StepDateGoal(
                    onDateChanged: (val) => _travelDate = val,
                    onGoalChanged: (val) => _goalAmount = val,
                    onNext: _nextPage,
                    initialDate: _travelDate,
                    initialGoal: _goalAmount,
                  ),
                  StepCurrencies(
                    onCurrenciesChanged: (val) => _monitoredCurrencies = val,
                    onNext: _nextPage,
                    initialCurrencies: _monitoredCurrencies,
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
