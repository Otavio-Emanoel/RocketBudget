import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionItem {
  final String id;
  final String title;
  final String category; // 'salary', 'freelance', 'gift', etc.
  final double amount;
  final DateTime date;
  final bool isExpense;

  TransactionItem({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    this.isExpense = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'isExpense': isExpense,
    };
  }

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: map['title'] ?? '',
      category: map['category'] ?? 'others',
      amount: map['amount']?.toDouble() ?? 0.0,
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      isExpense: map['isExpense'] ?? false,
    );
  }
}

class JourneyProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  String _userName = 'Traveler';
  String _destination = 'Not set';
  DateTime _targetDate = DateTime.now().add(const Duration(days: 365));
  double _goalAmount = 0.0;
  List<String> _currencies = ['USD'];
  List<TransactionItem> _transactions = [];

  // Getters
  String get userName => _userName;
  String get destination => _destination;
  DateTime get targetDate => _targetDate;
  double get goalAmount => _goalAmount;
  List<String> get currencies => _currencies;
  List<TransactionItem> get transactions => _transactions;

  double get totalSaved {
    return _transactions.fold(0.0, (sum, tx) => sum + (tx.isExpense ? -tx.amount : tx.amount));
  }

  int get daysRemaining {
    final diff = _targetDate.difference(DateTime.now()).inDays;
    return diff > 0 ? diff : 0;
  }

  double get progressPercentage {
    if (_goalAmount <= 0) return 0.0;
    final progress = totalSaved / _goalAmount;
    return progress > 1.0 ? 1.0 : (progress < 0 ? 0.0 : progress);
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();
  }

  void _loadData() {
    if (_prefs == null) return;
    
    _userName = _prefs!.getString('journey_user_name') ?? 'Traveler';
    _destination = _prefs!.getString('journey_destination') ?? 'World';
    
    final dateStr = _prefs!.getString('journey_target_date');
    if (dateStr != null) {
      _targetDate = DateTime.parse(dateStr);
    }
    
    _goalAmount = _prefs!.getDouble('journey_goal_amount') ?? 0.0;
    _currencies = _prefs!.getStringList('journey_currencies') ?? ['USD'];

    final txListJson = _prefs!.getStringList('journey_transactions') ?? [];
    _transactions = txListJson.map((txStr) => TransactionItem.fromMap(jsonDecode(txStr))).toList();
    
    notifyListeners();
  }

  Future<void> saveOnboardingData({
    required String name,
    required String destination,
    required DateTime dateGoal,
    required double goalAmount,
    required List<String> currencies,
  }) async {
    _userName = name;
    _destination = destination;
    _targetDate = dateGoal;
    _goalAmount = goalAmount;
    _currencies = currencies;

    await _prefs?.setString('journey_user_name', _userName);
    await _prefs?.setString('journey_destination', _destination);
    await _prefs?.setString('journey_target_date', _targetDate.toIso8601String());
    await _prefs?.setDouble('journey_goal_amount', _goalAmount);
    await _prefs?.setStringList('journey_currencies', _currencies);
    
    // Mark onboarding complete
    await _prefs?.setBool('onboarding_completed', true);

    notifyListeners();
  }

  Future<void> updateTripDetails({String? dest, DateTime? date, double? goal}) async {
    if (dest != null) {
      _destination = dest;
      await _prefs?.setString('journey_destination', _destination);
    }
    if (date != null) {
      _targetDate = date;
      await _prefs?.setString('journey_target_date', _targetDate.toIso8601String());
    }
    if (goal != null) {
      _goalAmount = goal;
      await _prefs?.setDouble('journey_goal_amount', _goalAmount);
    }
    notifyListeners();
  }

  Future<void> addTransaction(TransactionItem tx) async {
    _transactions.insert(0, tx); // Recent first
    await _saveTransactions();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((tx) => tx.id == id);
    await _saveTransactions();
    notifyListeners();
  }

  Future<void> _saveTransactions() async {
    final listStr = _transactions.map((tx) => jsonEncode(tx.toMap())).toList();
    await _prefs?.setStringList('journey_transactions', listStr);
  }
}
