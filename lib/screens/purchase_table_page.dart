import 'dart:io';

import 'package:ahmedadmin/models/purchase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PurchaseTablePage extends StatelessWidget {
  final String title;
  final List<Purchase> purchases;

  const PurchaseTablePage({
    required this.title,
    required this.purchases,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sortedPurchases = List<Purchase>.from(purchases)
      ..sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

    final totalAmount = purchases.fold<double>(
      0,
      (previousValue, purchase) =>
          previousValue + (purchase.pricePerUnit * purchase.quantity),
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
              // _printPdf(context, sortedPurchases, totalAmount);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24.0,
            headingRowHeight: 56.0,
            dataRowMinHeight: 48.0,
            dividerThickness: 0.5,
            columns: const [
              DataColumn(
                  label: Text('ቀን',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              DataColumn(
                  label: Text('እቃ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              DataColumn(
                  label: Text('ብዛት',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              DataColumn(
                  label: Text('ዋጋ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
              DataColumn(
                  label: Text('ጠቅላላ ዋጋ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))),
            ],
            rows: [
              ...sortedPurchases.asMap().entries.map((entry) {
                final index = entry.key;
                final purchase = entry.value;

                return DataRow(
                  cells: [
                    DataCell(Text(
                        DateFormat('M/d/yyyy').format(purchase.purchaseDate))),
                    DataCell(Text(purchase.productName)),
                    DataCell(Text('${purchase.quantity}')),
                    DataCell(
                      Text(
                        NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                            .format(purchase.pricePerUnit),
                      ),
                    ),
                    DataCell(
                      Text(
                        NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                            .format(
                                (purchase.quantity * purchase.pricePerUnit)),
                      ),
                    ),
                  ],
                );
              }).toList(),
              DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.08);
                    }
                    return Colors.grey[200];
                  },
                ),
                cells: [
                  const DataCell(Text('Total',
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  const DataCell(Text('')),
                  const DataCell(Text('')),
                  const DataCell(Text('')),
                  DataCell(
                    Text(
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(totalAmount),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _printPdf(BuildContext context, List<Purchase> sortedPurchases,
  //     double totalAmount) async {
  //   final pdf = pw.Document();
  //   final pdfTableHeaders = [
  //     'Index',
  //     'Product',
  //     'Quantity',
  //     'Price',
  //     'Total Price',
  //     'Date'
  //   ];

  //   final pdfTableData = sortedPurchases.asMap().entries.map((entry) {
  //     final index = entry.key + 1;
  //     final purchase = entry.value;

  //     return [
  //       '$index',
  //       purchase.productName ?? 'Unknown',
  //       '${purchase.quantity}',
  //       NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
  //           .format(purchase.pricePerUnit),
  //       NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
  //           .format(purchase.quantity * purchase.pricePerUnit),
  //       DateFormat.yMMMd().format(purchase.purchaseDate),
  //     ];
  //   }).toList();

  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           children: [
  //             pw.Text(title,
  //                 style: pw.TextStyle(
  //                     fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //             pw.SizedBox(height: 20),
  //             pw.TableHelper.fromTextArray(
  //               headers: pdfTableHeaders,
  //               data: pdfTableData,
  //               cellAlignment: pw.Alignment.centerLeft,
  //               border: pw.TableBorder.all(),
  //             ),
  //             pw.SizedBox(height: 20),
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.end,
  //               children: [
  //                 pw.Text(
  //                   'Total: ${NumberFormat.currency(locale: 'en_US', symbol: 'ETB ').format(totalAmount)}',
  //                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   final outputFile = await _getOutputFile();
  //   await outputFile.writeAsBytes(await pdf.save());

  //   // Print the saved PDF file
  //   await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => pdf.save(),
  //   );
  // }

  // Future<File> _getOutputFile() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = '${directory.path}/purchases_report_${DateTime.now()}.pdf';
  //   return File(path);
  // }
}
