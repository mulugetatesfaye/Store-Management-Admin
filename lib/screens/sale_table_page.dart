import 'package:ahmedadmin/models/product.dart';
import 'package:ahmedadmin/models/sale.dart';
import 'package:ahmedadmin/screens/sale_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleTablePage extends StatelessWidget {
  final String title;
  final List<Sale> sales;
  final List<Product> products;

  const SaleTablePage({
    required this.title,
    required this.sales,
    required this.products,
    super.key,
  });

  Future<int> calculateTotalQuantity() async {
    try {
      // Fetch all sales from Firestore
      final salesSnapshot =
          await FirebaseFirestore.instance.collection('sales').get();
      int totalQuantity = 0;
      for (var saleDoc in salesSnapshot.docs) {
        final saleData = saleDoc.data();
        final quantity =
            (saleData['quantity'] ?? 0) as num; // Ensure it's a num
        totalQuantity += quantity.toInt(); // Cast to int before summing
      }
      return totalQuantity;
    } catch (e) {
      print('Error calculating total quantity: $e');
      return 0; // Return 0 if an error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedSales = List<Sale>.from(sales)
      ..sort((a, b) => b.saleDate.compareTo(a.saleDate));

    final totalAmount = sales.fold<double>(
      0,
      (previousValue, sale) =>
          previousValue + (sale.pricePerUnit * sale.quantity),
    );

    final totalQuantity = sales.fold<int>(
      0,
      (previousValue, sale) => previousValue + sale.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
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
              // _printPdf(context, sortedSales, totalAmount);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8, bottom: 100),
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
                      label: Expanded(
                        child: Text(
                          '#',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ቀን',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'እቃ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ብዛት',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ዋጋ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ጠቅላላ ዋጋ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                  rows: [
                    ...sortedSales.asMap().entries.map((entry) {
                      final index = entry.key;
                      final sale = entry.value;

                      return DataRow(
                        cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(
                            Text(DateFormat('M/d/yyyy').format(sale.saleDate)),
                          ),
                          DataCell(Text(sale.productName)),
                          DataCell(Text('${sale.quantity}')),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                      locale: 'en_US', symbol: 'ETB ')
                                  .format(sale.pricePerUnit),
                            ),
                          ),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                      locale: 'en_US', symbol: 'ETB ')
                                  .format((sale.quantity * sale.pricePerUnit)),
                            ),
                          ),
                        ],
                        onSelectChanged: (selected) {
                          if (selected ?? false) {
                            // Navigate to detail page when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SaleDetailPage(sale: sale),
                              ),
                            );
                          }
                        },
                      );
                    }),
                    DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08);
                          }
                          return Colors.grey[200]; // Default value.
                        },
                      ),
                      cells: [
                        const DataCell(Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(Text('')),
                        const DataCell(Text('')),
                        DataCell(Text(
                          '$totalQuantity', // Display total quantity here
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataCell(Text('')),
                        DataCell(Text(
                          NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                              .format(totalAmount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'መጋዘን የቀረ:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '${product.name}: ${product.stock}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
