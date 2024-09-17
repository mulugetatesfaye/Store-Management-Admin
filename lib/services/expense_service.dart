import 'package:ahmedadmin/models/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Expense>> getExpenses() {
    return _firestore
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList());
  }

  Future<void> createExpense(Expense expense) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(expense.expenseId)
          .set(expense.toJson());
      print('Expense created successfully.');
    } catch (e) {
      print('Error creating expense: $e');
      throw Exception('Failed to create expense. Please try again.');
    }
  }

  Future<Expense?> getExpense(String expenseId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('expenses').doc(expenseId).get();
      if (doc.exists) {
        return Expense.fromJson(doc.data()!);
      } else {
        print('Expense not found.');
        return null;
      }
    } catch (e) {
      print('Error reading expense: $e');
      throw Exception('Failed to fetch expense data.');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(expense.expenseId)
          .update(expense.toJson());
      print('Expense updated successfully.');
    } catch (e) {
      print('Error updating expense: $e');
      throw Exception('Failed to update expense data.');
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      await _firestore.collection('expenses').doc(expenseId).delete();
      print('Expense deleted successfully.');
    } catch (e) {
      print('Error deleting expense: $e');
      throw Exception('Failed to delete expense.');
    }
  }
}
