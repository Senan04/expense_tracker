import 'package:expense_tracker/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({required this.expenses, super.key});

  final List<Expense> expenses;

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 2,
            centerSpaceRadius: 0,
            sections: sections,
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> get sections {
    final double totalExpenses =
        ExpenseBucket(expenses: widget.expenses).totalExpenses;
    final Map<Category, double> categoryTotal = {};
    for (final category in Category.values) {
      categoryTotal[category] = ExpenseBucket.forCategory(
              allExpenses: widget.expenses, category: category)
          .totalExpenses;
    }
    return categoryTotal.entries.map((entry) {
      double percentage = double.parse(
          ((entry.value / totalExpenses) * 100).toStringAsFixed(2));
      return PieChartSectionData(
        value: percentage,
        color: categoryColors[entry.key],
        radius: 150,
        showTitle: true,
        title: '$percentage %',
        titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        badgeWidget: IconButton.filled(
          onPressed: () {},
          icon: Icon(categoryIcons[entry.key]),
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
        ),
        badgePositionPercentageOffset: .98,
        titlePositionPercentageOffset: .65,
      );
    }).toList();
  }
}