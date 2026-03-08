import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class StepDateGoal extends StatefulWidget {
  final ValueChanged<DateTime?> onDateChanged;
  final ValueChanged<double> onGoalChanged;
  final VoidCallback onNext;
  final DateTime? initialDate;
  final double initialGoal;

  const StepDateGoal({
    super.key,
    required this.onDateChanged,
    required this.onGoalChanged,
    required this.onNext,
    this.initialDate,
    this.initialGoal = 0,
  });

  @override
  State<StepDateGoal> createState() => _StepDateGoalState();
}

class _StepDateGoalState extends State<StepDateGoal> {
  DateTime? _selectedDate;
  final TextEditingController _goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now().add(const Duration(days: 365));
    if (widget.initialGoal > 0) {
      _goalController.text = widget.initialGoal.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  double get _currentGoal {
    return double.tryParse(_goalController.text) ?? 0.0;
  }

  double get _monthlyProjection {
    if (_selectedDate == null || _currentGoal <= 0) return 0;
    
    final now = DateTime.now();
    int months = (_selectedDate!.year - now.year) * 12 + _selectedDate!.month - now.month;
    if (months <= 0) months = 1; // At least 1 month
    
    return _currentGoal / months;
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.neonBlue,
              onPrimary: AppColors.backgroundDark,
              surface: AppColors.cardDark,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quando será a sua\ndecolagem?',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1),
          
          const SizedBox(height: 12),

          Text(
            'Defina sua meta e a data da viagem para o Astro calcular seu combustível.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF94a3b8),
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 32),

          // Date Picker
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded, color: AppColors.neonBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Data da Viagem',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ).animate().fadeIn(delay: 300.ms),
          
          const SizedBox(height: 12),

          GestureDetector(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null 
                        ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                        : 'Selecionar Data',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(Icons.calendar_today_rounded, color: Colors.white54, size: 18),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 32),

          // Goal Input
          Row(
            children: [
              const Icon(Icons.money_rounded, color: AppColors.neonBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Meta de Economia',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ).animate().fadeIn(delay: 500.ms),
          
          const SizedBox(height: 12),

          TextField(
            controller: _goalController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
            onChanged: (val) {
              setState(() {}); // Trigger rebuild for projection
              widget.onGoalChanged(double.tryParse(val) ?? 0);
            },
            style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.cardDark,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('R\$', style: GoogleFonts.inter(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              hintText: '5000',
              hintStyle: GoogleFonts.inter(color: Colors.white38, fontSize: 24),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: 8),
          
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              Text(
                'Estimativa média para uma viagem de 7 dias.',
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 12),
              ),
            ],
          ).animate().fadeIn(delay: 700.ms),

          const Spacer(),

          // Projection Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.neonBlue.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.neonBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.show_chart_rounded, color: AppColors.backgroundDark, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Projeção Astro',
                        style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(color: const Color(0xFF94a3b8), fontSize: 13, height: 1.4),
                          children: [
                            const TextSpan(text: 'Com essa meta, você precisará poupar aproximadamente '),
                            TextSpan(
                              text: 'R\$ ${_monthlyProjection.toStringAsFixed(2)}/mês',
                              style: const TextStyle(color: AppColors.neonBlue, fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: ' até a decolagem.'),
                          ],
                        ),
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
            onPressed: () {
              if (_currentGoal > 0 && _selectedDate != null) {
                widget.onNext();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, informe uma data e uma meta válida.')),
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
                  'Próximo Passo',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 20),
              ],
            ),
          ).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }
}
