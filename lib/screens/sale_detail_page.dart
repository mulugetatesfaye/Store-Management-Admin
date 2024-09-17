import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ahmedadmin/models/sale.dart'; // Assuming Sale model is imported

class SaleDetailPage extends StatelessWidget {
  final Sale sale;

  const SaleDetailPage({required this.sale, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'የሽያጭ ዝርዝር',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(context),
            const SizedBox(height: 20),
            _buildTotalInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              context,
              'ብዛት:',
              '${sale.quantity}',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              'ዋጋ በአንዱ:',
              NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                  .format(sale.pricePerUnit),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              'ቀን:',
              DateFormat('M/d/yyyy').format(sale.saleDate),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              'እቃ:',
              sale.productName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalInfo(BuildContext context) {
    final totalAmount = sale.quantity * sale.pricePerUnit;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.blueGrey[50],
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ጠቅላላ ዋጋ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                  .format(totalAmount),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
