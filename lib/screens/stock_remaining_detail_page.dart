import 'package:ahmedadmin/models/product.dart';
import 'package:flutter/material.dart';

class StockRemainingDetailPage extends StatelessWidget {
  final List<Product> products;

  const StockRemainingDetailPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final sortedProducts = List<Product>.from(products)
      ..sort((a, b) => a.name.compareTo(b.name)); // Sorting by product name

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'መጋዘን ውስጥ የቀረ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  columnSpacing: 24.0,
                  headingRowHeight: 56.0,
                  dataRowHeight: 48.0,
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
                      label: Expanded(
                        child: Text(
                          'የእቃው አይነት',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'መጋዘን የቀረ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    ...sortedProducts.asMap().entries.map((entry) {
                      final index = entry.key;
                      final product = entry.value;

                      return DataRow(
                        cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(product.name)),
                          DataCell(Text('${product.stock}')),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
