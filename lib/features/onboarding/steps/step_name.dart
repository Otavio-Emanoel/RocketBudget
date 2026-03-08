import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class StepName extends StatefulWidget {
  final ValueChanged<String> onNameChanged;
  final VoidCallback onNext;
  final String initialName;

  const StepName({
    super.key,
    required this.onNameChanged,
    required this.onNext,
    this.initialName = '',
  });

  @override
  State<StepName> createState() => _StepNameState();
}

class _StepNameState extends State<StepName> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Graphic / Mascot
          Expanded(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                color: Colors.white, // In the mockup, the astronaut has a white/light gray background block. But we'll use a clean dark container to fit our theme better, or just show the transparent PNG.
                child: Image.asset(
                  'assets/images/astro_3d.png',
                  fit: BoxFit.contain,
                ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -5, end: 5, duration: 2.seconds),
              ),
            ),
          ),
          
          const SizedBox(height: 24),

          // Titles
          Text(
            'Qual o seu nome,\n',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
          Text(
            'Comandante?',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.neonBlue,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

          const SizedBox(height: 16),

          Text(
            'Astro precisa saber como te chamar na cabine de comando.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF94a3b8),
            ),
          ).animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 48),

          // Input Field
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonBlue.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ],
            ),
            child: TextField(
              controller: _nameController,
              onChanged: widget.onNameChanged,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardDark,
                prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.neonBlue),
                hintText: 'Ex: Neil Armstrong',
                hintStyle: GoogleFonts.inter(color: Colors.white38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.neonBlue.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.neonBlue.withOpacity(0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.neonBlue),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: 40),

          // Next Button Layout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left indicators (dots)
              Row(
                children: [
                  Container(width: 24, height: 6, decoration: BoxDecoration(color: AppColors.neonBlue, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 8),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 8),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(3))),
                ],
              ),
              
              // Next Btn
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    widget.onNext();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor, insira seu nome.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonBlue,
                  foregroundColor: AppColors.backgroundDark,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Próximo',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(delay: 800.ms),
          
          const SizedBox(height: 24),
          
          Text(
            'SISTEMA DE NAVEGAÇÃO ESTELAR V2.0',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF475569),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
