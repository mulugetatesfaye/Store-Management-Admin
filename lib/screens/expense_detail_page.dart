import 'package:ahmedadmin/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailPage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ወጪ ዝርዝር',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ወጪ አይነት', expense.type),
            _buildDetailRow('ቀን', DateFormat('M/d/yyyy').format(expense.date)),
            _buildDetailRow('መግለጫ', expense.description),
            _buildDetailRow(
              'መጠን',
              NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                  .format(expense.amount),
            ),
            const SizedBox(height: 16),
            if (expense.receiptImages.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _viewReceipt(context, expense.receiptImages.first);
                },
                child: Container(
                  width: double.infinity,
                  height: 200, // Adjust height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        expense.receiptImages.first,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: const Text(
                          'ደረሰኝ ይመልከቱ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 200, // Adjust height as needed
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'ደረሰኝ የለም',
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _viewReceipt(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Make the background transparent
        child: InteractiveViewer(
          child: Image.network(
            image,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Failed to load image'));
            },
          ),
        ),
      ),
    );
  }
}
