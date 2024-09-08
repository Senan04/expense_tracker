import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;

  final void Function(Expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (ctx) => removeExpense(expenses[index]),
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Löschen',
            ),
          ],
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
          color: const Color.fromARGB(255, 233, 233, 233),
          child: ListTile(
            leading: Icon(categoryIcons[expenses[index].category]),
            title: Text(expenses[index].title),
            subtitle: Text(expenses[index].formattedDate),
            trailing: Text('${expenses[index].amount.toStringAsFixed(2)} €'),
          ),
        ),
      ),
    );
  }
}
