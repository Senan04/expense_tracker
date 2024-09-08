import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/expenses_chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _savedExpenses = [];

  void _showOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(addExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _savedExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _savedExpenses.indexOf(expense);
    setState(() {
      _savedExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Element gelöscht'),
        action: SnackBarAction(
          label: 'Wiederherstellen',
          onPressed: () => setState(() {
            _savedExpenses.insert(index, expense);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Widget> content = [
      ExpensesChart(expenses: _savedExpenses),
      Expanded(
        child: ExpensesList(
          expenses: _savedExpenses,
          removeExpense: _removeExpense,
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ausgaben'),
        actions: [
          IconButton(onPressed: _showOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: _savedExpenses.isEmpty
          ? const Center(child: Text('Keine Einträge'))
          : height > width
              ? Column(
                  children: content,
                )
              : Row(
                  children: content,
                ),
    );
  }
}
