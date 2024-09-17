import 'package:ahmedadmin/models/expense.dart';
import 'package:ahmedadmin/screens/expense_detail_page.dart';
import 'package:ahmedadmin/screens/forms/expense_form.dart';
import 'package:ahmedadmin/services/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseListPage extends StatelessWidget {
  final ExpenseService _expenseService = ExpenseService();

  ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Expense>>(
        stream: _expenseService.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          final expenses = snapshot.data ?? [];

          if (expenses.isEmpty) {
            return _buildEmptyState();
          }

          double totalAmount =
              expenses.fold(0, (sum, expense) => sum + expense.amount);

          return Column(
            children: [
              _buildTotalExpensesHeader(totalAmount),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return _buildExpenseCard(context, expense);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ExpenseForm(),
            ),
          );
        },
        label: const Text('ወጪ አስገባ'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildTotalExpensesHeader(double totalAmount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ጠቅላላ ወጪ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                .format(totalAmount),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(BuildContext context, Expense expense) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: const Icon(
            Icons.money_off,
            color: Colors.teal,
          ),
        ),
        title: Text(
          expense.type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'ቀን: ${DateFormat('M/d/yyyy').format(expense.date)}\nዝርዝር: ${expense.description}',
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: Text(
          NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
              .format(expense.amount),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ExpenseDetailPage(expense: expense),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(
            'Error: $errorMessage',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_alt, color: Colors.grey, size: 60),
          SizedBox(height: 16),
          Text(
            'ለጊዜው ምንም ሽያጭ የለም',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
