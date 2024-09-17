import 'package:ahmedadmin/models/damaged_product.dart';
import 'package:ahmedadmin/screens/forms/damaged_product_form.dart';
import 'package:ahmedadmin/services/damaged_product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DamagedProductsPage extends ConsumerWidget {
  const DamagedProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final damagedProductService = DamagedProductService();

    return Scaffold(
      body: StreamBuilder<List<DamagedProduct>>(
        stream: damagedProductService.getDamagedProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ለጊዜው ምንም የተበላሸ እቃ የለም.'));
          }

          final damagedProducts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            itemCount: damagedProducts.length,
            itemBuilder: (context, index) {
              final product = damagedProducts[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  title: Text(
                    product.productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  leading: const Icon(
                    Icons.delete_forever_sharp,
                    color: Colors.red,
                    size: 30,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ምክንያት: ${product.reason}'),
                      Text(
                          'ሪፖርት የተደረገበት: ${DateFormat.yMMMd().format(product.reportedAt.toLocal())}'),
                    ],
                  ),
                  trailing: Text(
                    'ብዛት: ${product.quantity}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DamagedProductForm(),
            ),
          );
        },
        label: const Text('የተበላሸ እቃ አስገባ'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
