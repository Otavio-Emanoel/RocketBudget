import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class StepDestination extends StatefulWidget {
  final ValueChanged<String> onDestinationChanged;
  final VoidCallback onNext;
  final String initialDestination;

  const StepDestination({
    super.key,
    required this.onDestinationChanged,
    required this.onNext,
    this.initialDestination = '',
  });

  @override
  State<StepDestination> createState() => _StepDestinationState();
}

class _StepDestinationState extends State<StepDestination> {
  String _selectedDest = '';

  final List<Map<String, dynamic>> _destinations = [
    {'name': 'Canadá', 'icon': '🍁', 'emoji': true},
    {'name': 'EUA', 'icon': Icons.location_city_rounded, 'emoji': false},
    {'name': 'Reino Unido', 'icon': '🇬🇧', 'emoji': true},
    {'name': 'Irlanda', 'icon': '☘️', 'emoji': true},
    {'name': 'Austrália', 'icon': '🦘', 'emoji': true},
    {'name': 'Outros', 'icon': Icons.public_rounded, 'emoji': false},
  ];

  @override
  void initState() {
    super.initState();
    _selectedDest = widget.initialDestination;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Para onde o foguete vai\ndecolar?',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
          
          const SizedBox(height: 24),

          // Search Field
          TextField(
            style: GoogleFonts.inter(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.cardDark,
              prefixIcon: const Icon(Icons.search_rounded, color: Colors.white54),
              hintText: 'Pesquisar destino...',
              hintStyle: GoogleFonts.inter(color: Colors.white38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.neonBlue),
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 32),

          Text(
            'Destinos populares',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 16),

          // Grid
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: _destinations.length,
              itemBuilder: (context, index) {
                final dest = _destinations[index];
                final isSelected = _selectedDest == dest['name'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDest = dest['name'] as String;
                    });
                    widget.onDestinationChanged(_selectedDest);
                  },
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
                            child: dest['emoji'] == true
                                ? Text(dest['icon'] as String, style: const TextStyle(fontSize: 24))
                                : Icon(dest['icon'] as IconData, color: isSelected ? AppColors.neonBlue : Colors.white70),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          dest['name'] as String,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (400 + (index * 100)).ms).scale(curve: Curves.easeOutBack),
                );
              },
            ),
          ),

          // Next Btn
          ElevatedButton(
            onPressed: () {
              if (_selectedDest.isNotEmpty) {
                widget.onNext();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, escolha um destino.')),
                );
              }
            },
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
                  'Continuar',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.rocket_launch_rounded, size: 20),
              ],
            ),
          ).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }
}
