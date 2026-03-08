import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class StepCurrencies extends StatefulWidget {
  final ValueChanged<List<String>> onCurrenciesChanged;
  final VoidCallback onNext;
  final List<String> initialCurrencies;

  const StepCurrencies({
    super.key,
    required this.onCurrenciesChanged,
    required this.onNext,
    this.initialCurrencies = const ['USD'],
  });

  @override
  State<StepCurrencies> createState() => _StepCurrenciesState();
}

class _StepCurrenciesState extends State<StepCurrencies> {
  late List<String> _selectedCurrencies;

  final List<Map<String, String>> _currencies = [
    {'code': 'USD', 'name': 'Dólar', 'symbol': 'US'},
    {'code': 'EUR', 'name': 'Euro', 'symbol': 'EU'},
    {'code': 'GBP', 'name': 'Libra', 'symbol': 'UK'},
    {'code': 'CAD', 'name': 'Dólar Can.', 'symbol': 'CA'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCurrencies = List.from(widget.initialCurrencies);
  }

  void _toggleCurrency(String code) {
    setState(() {
      if (_selectedCurrencies.contains(code)) {
        if (_selectedCurrencies.length > 1) { // Ensure at least one is selected
          _selectedCurrencies.remove(code);
        }
      } else {
        _selectedCurrencies.add(code);
      }
    });
    widget.onCurrenciesChanged(_selectedCurrencies);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Radar Icon
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cardDark,
                border: Border.all(color: AppColors.neonBlue.withOpacity(0.3)),
              ),
              child: const Icon(Icons.radar_rounded, color: AppColors.neonBlue, size: 40)
            )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(begin: const Offset(1,1), end: const Offset(1.1, 1.1), duration: 1.seconds)
            .then()
            .scale(duration: 1.seconds),
          ),
          
          const SizedBox(height: 24),

          Text(
            'Quais moedas vamos\nmonitorar?',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ).animate().fadeIn(duration: 400.ms),
          
          const SizedBox(height: 12),

          Text(
            'O Astro usará o Radar para te avisar os melhores momentos para comprar.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF94a3b8),
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 32),

          // Grid of Currencies
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: _currencies.length,
              itemBuilder: (context, index) {
                final curr = _currencies[index];
                final isSelected = _selectedCurrencies.contains(curr['code']);

                return GestureDetector(
                  onTap: () => _toggleCurrency(curr['code']!),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.cardDark : AppColors.backgroundDarker,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.neonBlue : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.neonBlue.withOpacity(0.2),
                                blurRadius: 20,
                              )
                            ]
                          : [],
                    ),
                    child: Stack(
                      children: [
                        if (isSelected)
                          const Positioned(
                            top: 12,
                            right: 12,
                            child: Icon(Icons.check_circle_rounded, color: AppColors.neonBlue, size: 20),
                          ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.neonBlue.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    curr['symbol']!,
                                    style: GoogleFonts.inter(
                                      color: isSelected ? AppColors.neonBlue : Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                curr['name']!,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                curr['code']!,
                                style: GoogleFonts.inter(
                                  color: isSelected ? AppColors.neonBlue : const Color(0xFF64748b),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (400 + (index * 100)).ms),
                );
              },
            ),
          ),

          // Radar Notification Info Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.neonBlue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_active_rounded, color: AppColors.neonBlue, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Radar Espacial Ativado',
                        style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Você receberá um push quando as taxas caírem.',
                        style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2),

          const SizedBox(height: 24),

          // Next Btn
          ElevatedButton(
            onPressed: widget.onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonBlue,
              foregroundColor: AppColors.backgroundDark,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pronto para Decolar',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.rocket_launch_rounded, size: 20),
              ],
            ),
          ).animate().fadeIn(delay: 1000.ms),
          
          const SizedBox(height: 16),
          
          TextButton(
            onPressed: widget.onNext,
            child: Text(
              'Configurar mais tarde',
              style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontWeight: FontWeight.w600),
            ),
          ).animate().fadeIn(delay: 1100.ms),
        ],
      ),
    );
  }
}
