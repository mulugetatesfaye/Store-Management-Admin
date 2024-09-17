import 'package:ahmedadmin/models/purchase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseDetailPage extends StatelessWidget {
  final Purchase purchased;

  const PurchaseDetailPage({
    Key? key,
    required this.purchased,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(purchased.productName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image and Name
            Row(
              children: [
                if (purchased.imageUrls != null &&
                    purchased.imageUrls!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      purchased.imageUrls!.first,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        purchased.productName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(
                      //   'ዝርዝር: ${purchased.}',
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Purchase Details
            _buildDetailRow('ብዛት', '${purchased.quantity}'),
            _buildDetailRow(
                'ዋጋ',
                NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                    .format(purchased.pricePerUnit)),
            _buildDetailRow(
              'ጠቅላላ ዋጋ',
              NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                  .format(purchased.quantity * purchased.pricePerUnit),
            ),
            _buildDetailRow(
                'የተገዛበት ቀን', DateFormat.yMMMd().format(purchased.purchaseDate)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
