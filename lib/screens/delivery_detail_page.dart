import 'package:ahmedadmin/models/delivery.dart';
import 'package:ahmedadmin/screens/forms/delivery_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryDetailPage extends StatelessWidget {
  final Delivery delivery;

  const DeliveryDetailPage({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('የጫነ መኪና ዝርዝር'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryEditPage(delivery: delivery),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ስም', delivery.name),
            _buildDetailRow('ታርጋ ቁጥር', delivery.licenseNumber),
            _buildDetailRow('ስልክ ቁጥር', delivery.contactInfo),
            _buildDetailRow('ሁኔታ', delivery.status),
            _buildDetailRow(
                'ቀን', DateFormat('M/d/yyyy').format(delivery.createdAt)),
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
