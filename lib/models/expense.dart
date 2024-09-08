import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final dateFormatter = DateFormat.yMMMEd('de_DE');

enum Category {
  sonstiges,
  rechnungen,
  lebensmittel,
  restaurant,
  transport,
  reisen,
  freizeit,
  kleidung,
  hobbys
}

const categoryIcons = {
  Category.sonstiges: Icons.dataset,
  Category.rechnungen: Icons.receipt,
  Category.lebensmittel: Icons.local_grocery_store,
  Category.restaurant: Icons.restaurant,
  Category.reisen: Icons.flight,
  Category.freizeit: Icons.movie,
  Category.transport: Icons.train,
  Category.kleidung: Icons.checkroom,
  Category.hobbys: Icons.sports_esports,
};

/*const categoryColors = {
  Category.sonstiges: Color.fromARGB(255, 247, 243, 9),
  Category.rechnungen: Color.fromARGB(255, 224, 148, 49),
  Category.lebensmittel: Color.fromARGB(255, 21, 124, 25),
  Category.restaurant: Color.fromARGB(255, 17, 176, 187), 
  Category.reisen: Color.fromARGB(255, 111, 65, 197),
  Category.freizeit: Color.fromARGB(255, 25, 81, 145),
  Category.transport: Color.fromARGB(255, 180, 17, 71),
  Category.kleidung: Color.fromARGB(255, 160, 150, 17),
  Category.hobbys: Color.fromARGB(255, 6, 26, 94),
};*/

const categoryColors = {
  Category.sonstiges: Color(0xFF6B8E23),
  Category.rechnungen: Color(0xFF9F40FF),
  Category.lebensmittel: Color(0xFF36A2EB),
  Category.restaurant: Color(0xFFCE56FF),
  Category.reisen: Color(0xFF4BC0C0),
  Category.freizeit: Color(0xFF9966FF),
  Category.transport: Color.fromARGB(255, 162, 207, 102),
  Category.kleidung: Color.fromARGB(255, 89, 199, 104),
  Category.hobbys: Color(0xFF6384FF),
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses});

  ExpenseBucket.forCategory(
      {required List<Expense> allExpenses, required Category category})
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (Expense expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
