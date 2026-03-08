import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/providers/journey_provider.dart';

class AddTransactionModal extends StatefulWidget {
  const AddTransactionModal({super.key});

  @override
  State<AddTransactionModal> createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'freelance'; // default
  bool _isExpense = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'salary', 'label': 'Trabalho', 'icon': Icons.work_rounded},
    {'id': 'freelance', 'label': 'Freelance', 'icon': Icons.computer_rounded},
    {'id': 'raffle', 'label': 'Rifa', 'icon': Icons.confirmation_num_rounded},
    {'id': 'gift', 'label': 'Presente', 'icon': Icons.card_giftcard_rounded},
    {'id': 'others', 'label': 'Outros', 'icon': Icons.category_rounded},
  ];

  void _saveTransaction() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    final amount = double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0;
    if (amount <= 0) return;

    final tx = TransactionItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      category: _selectedCategory,
      amount: amount,
      date: DateTime.now(),
      isExpense: _isExpense,
    );

    context.read<JourneyProvider>().addTransaction(tx);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Novo Registro',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Type Selector (Entrada / Saída)
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isExpense = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: !_isExpense ? AppColors.neonBlue.withOpacity(0.2) : Colors.transparent,
                      border: Border.all(color: !_isExpense ? AppColors.neonBlue : Colors.white24),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text('Entrada (Guardado)', style: GoogleFonts.inter(color: !_isExpense ? AppColors.neonBlue : Colors.white54, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isExpense = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _isExpense ? Colors.redAccent.withOpacity(0.2) : Colors.transparent,
                      border: Border.all(color: _isExpense ? Colors.redAccent : Colors.white24),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text('Saída (Gasto)', style: GoogleFonts.inter(color: _isExpense ? Colors.redAccent : Colors.white54, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Title Input
          TextField(
            controller: _titleController,
            style: GoogleFonts.inter(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Título (ex: Venda da Rifa)',
              labelStyle: GoogleFonts.inter(color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),

          // Amount Input
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              prefixText: 'R\$ ',
              prefixStyle: GoogleFonts.inter(color: AppColors.neonBlue, fontSize: 24, fontWeight: FontWeight.bold),
              labelText: 'Valor',
              labelStyle: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),

          // Categories
          Text('Categoria', style: GoogleFonts.inter(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat['id'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat['id']),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.neonBlue.withOpacity(0.1) : Colors.transparent,
                      border: Border.all(color: isSelected ? AppColors.neonBlue : Colors.white24),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Icon(cat['icon'], color: isSelected ? AppColors.neonBlue : Colors.white54, size: 16),
                        const SizedBox(width: 8),
                        Text(cat['label'], style: GoogleFonts.inter(color: isSelected ? AppColors.neonBlue : Colors.white54)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 32),

          // Save Button
          ElevatedButton(
            onPressed: _saveTransaction,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonBlue,
              foregroundColor: AppColors.backgroundDark,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              _isExpense ? 'Registrar Gasto' : 'Guardar Dinheiro 🚀',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
