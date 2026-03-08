import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/journey_provider.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const RocketBudgetApp());
}

class RocketBudgetApp extends StatelessWidget {
  const RocketBudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JourneyProvider(),
      child: MaterialApp(
        title: 'RocketBudget',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
