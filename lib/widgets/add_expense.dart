import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addExpense});

  final void Function(Expense) addExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? _userDate;
  Category? _selectedCategory;
  //Controller
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  //Error Variablen
  String? _titleError;
  String? _sumError;
  bool _userDateError = false;
  bool _categoryError = false;

  //Immer überschreiben, wenn Controller genutzt werden. Wird autom. aufgerufen!
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      _userDate = pickedDate;
      _userDateError = false;
    });
  }

  void _saveExpense() {
    var amount = double.tryParse(_amountController.text);
    setState(() {
      _titleController.text.trim().isEmpty
          ? _titleError = 'Bitte gebe einen Titel ein'
          : _titleError = null;
      (amount == null || amount <= 0)
          ? _sumError = 'Bitte gebe eine Summe ein'
          : _sumError = null;
      _userDate == null ? _userDateError = true : _userDateError = false;
      _selectedCategory == null
          ? _categoryError = true
          : _categoryError = false;
    });
    if (_titleError == null &&
        _sumError == null &&
        !_userDateError &&
        !_categoryError) {
      widget.addExpense(Expense(
        title: _titleController.text,
        amount: amount!,
        date: _userDate!,
        category: _selectedCategory!,
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 20),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                  label: const Text('Titel'),
                  errorText: _titleError,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: const Text('Summe'),
                        suffixText: '€',
                        errorText: _sumError,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _userDate == null
                                ? 'Kein Datum ausgewählt'
                                : dateFormatter.format(_userDate!),
                            style: TextStyle(
                                color: _userDateError
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context).colorScheme.secondary),
                          ),
                          IconButton(
                            onPressed: _showDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ]),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                    hint: Text(
                      'Kategorie',
                      style: TextStyle(
                          color: _categoryError
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.secondary),
                    ),
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Abbrechen'),
                  ),
                  // ElevatedButton(
                  //   onPressed: _saveExpense,
                  //   child: const Text('Speichern'),
                  // ),
                  ElevatedButton.icon(
                    onPressed: _saveExpense,
                    icon: const Icon(Icons.save),
                    label: const Text('Speichern'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
