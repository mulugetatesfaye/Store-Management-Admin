import 'package:ahmedadmin/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense_detail_page.dart'; // Import the detail page

class ExpenseTablePage extends StatefulWidget {
  final String title;
  final List<Expense> expenses;

  const ExpenseTablePage({
    required this.title,
    required this.expenses,
    super.key,
  });

  @override
  _ExpenseTablePageState createState() => _ExpenseTablePageState();
}

class _ExpenseTablePageState extends State<ExpenseTablePage> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    // Filter expenses based on the selected type
    final filteredExpenses = _selectedType == null
        ? widget.expenses
        : widget.expenses
            .where((expense) => expense.type == _selectedType)
            .toList();

    // Sort expenses by date in descending order
    final sortedExpenses = List<Expense>.from(filteredExpenses)
      ..sort((a, b) => b.date.compareTo(a.date));

    // Calculate the total amount
    final totalAmount = sortedExpenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );

    // Get unique expense types for the filter dropdown
    final expenseTypes = widget.expenses.map((e) => e.type).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              // _printPdf(context, sortedExpenses, totalAmount);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 200, // Adjust width as needed
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: InputDecoration(
                    labelText: 'Filter',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  items: ['All', ...expenseTypes].map((type) {
                    return DropdownMenuItem(
                      value: type == 'All' ? null : type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 24.0,
                    headingRowHeight: 56.0,
                    dataRowMinHeight: 48.0,
                    dividerThickness: 0.5,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'ቀን',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ዝርዝር',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ምክንያት',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'የወጣው ብር',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                    rows: sortedExpenses.map((expense) {
                      return DataRow(
                        onSelectChanged: (_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExpenseDetailPage(expense: expense),
                            ),
                          );
                        },
                        cells: [
                          DataCell(Text(
                              DateFormat('M/d/yyyy').format(expense.date))),
                          DataCell(Text(expense.description)),
                          DataCell(Text(expense.type)),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                      locale: 'en_US', symbol: 'ETB ')
                                  .format(expense.amount),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
