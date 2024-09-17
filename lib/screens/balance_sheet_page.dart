import 'dart:io';

import 'package:ahmedadmin/models/expense.dart';
import 'package:ahmedadmin/models/sale.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class BalanceSheetPage extends StatefulWidget {
  final List<Sale> sales;
  final List<Expense> expenses;

  const BalanceSheetPage({
    required this.sales,
    required this.expenses,
    super.key,
  });

  @override
  _BalanceSheetPageState createState() => _BalanceSheetPageState();
}

class _BalanceSheetPageState extends State<BalanceSheetPage> {
  bool showSales = true;

  @override
  Widget build(BuildContext context) {
    // Calculate total sales amount
    final totalSales = widget.sales.fold<double>(
      0,
      (previousValue, sale) =>
          previousValue + (sale.pricePerUnit * sale.quantity),
    );

    // Calculate total expenses
    final totalExpenses = widget.expenses.fold<double>(
      0,
      (previousValue, expense) => previousValue + expense.amount,
    );

    // Calculate net profit or loss
    final netAmount = totalSales - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ከወጪ ቀሪ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: exportToPdf,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      children: [
                        ChoiceChip(
                          label: const Text('አጠቃላይ ሽያጭ'),
                          selected: showSales,
                          onSelected: (selected) {
                            setState(() {
                              showSales = selected;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: const Text('አጠቃላይ ወጪ'),
                          selected: !showSales,
                          onSelected: (selected) {
                            setState(() {
                              showSales = !selected;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (showSales) ...[
                      const Text(
                        'አጠቃላይ ሽያጭ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('ቀን')),
                            DataColumn(label: Text('ምርት')),
                            DataColumn(label: Text('ብዛት')),
                            DataColumn(label: Text('የአንዱ ዋጋ')),
                            DataColumn(label: Text('አጠቃላይ ዋጋ')),
                          ],
                          rows: widget.sales.map((sale) {
                            return DataRow(
                              cells: [
                                DataCell(Text(DateFormat('M/d/yyyy')
                                    .format(sale.saleDate))),
                                DataCell(Text(sale.productName)),
                                DataCell(Text(sale.quantity.toString())),
                                DataCell(Text(NumberFormat.currency(
                                        locale: 'en_US', symbol: 'ETB ')
                                    .format(sale.pricePerUnit))),
                                DataCell(Text(NumberFormat.currency(
                                        locale: 'en_US', symbol: 'ETB ')
                                    .format(
                                        sale.pricePerUnit * sale.quantity))),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'አጠቃላይ ወጪ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('ቀን')),
                            DataColumn(label: Text('መግለጫ')),
                            DataColumn(label: Text('ምክንያት')),
                            DataColumn(label: Text('ብር')),
                          ],
                          rows: widget.expenses.map((expense) {
                            return DataRow(
                              cells: [
                                DataCell(Text(DateFormat('M/d/yyyy')
                                    .format(expense.date))),
                                DataCell(Text(expense.description)),
                                DataCell(Text(expense.type)),
                                DataCell(Text(NumberFormat.currency(
                                        locale: 'en_US', symbol: 'ETB ')
                                    .format(expense.amount))),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'አጠቃላይ ሽያጭ ድምር:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(totalSales),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'አጠቃላይ ወጪ ድምር:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(totalExpenses),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ቀሪ:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(netAmount),
                      style: TextStyle(
                        color: netAmount >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final currentDate = dateFormatter.format(DateTime.now());
    final fileName = 'BalanceSheet_$currentDate.pdf';

    // Calculate totals and net amount
    final totalSales = widget.sales.fold<double>(
      0,
      (previousValue, sale) =>
          previousValue + (sale.pricePerUnit * sale.quantity),
    );

    final totalExpenses = widget.expenses.fold<double>(
      0,
      (previousValue, expense) => previousValue + expense.amount,
    );

    final netAmount = totalSales - totalExpenses;

    try {
      final pdfContent = pw.Column(
        children: [
          pw.Text(
            showSales ? 'አጠቃላይ ሽያጭ' : 'አጠቃላይ ወጪ',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 20),
          showSales
              ? pw.TableHelper.fromTextArray(
                  headers: ['ቀን', 'ምርት', 'ብዛት', 'የአንዱ ዋጋ', 'አጠቃላይ ዋጋ'],
                  data: widget.sales.map((sale) {
                    return [
                      DateFormat('M/d/yyyy').format(sale.saleDate),
                      sale.productName,
                      sale.quantity.toString(),
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(sale.pricePerUnit),
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(sale.pricePerUnit * sale.quantity),
                    ];
                  }).toList(),
                )
              : pw.TableHelper.fromTextArray(
                  headers: ['ቀን', 'መግለጫ', 'ምክንያት', 'ብር'],
                  data: widget.expenses.map((expense) {
                    return [
                      DateFormat('M/d/yyyy').format(expense.date),
                      expense.description,
                      expense.type,
                      NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                          .format(expense.amount),
                    ];
                  }).toList(),
                ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('አጠቃላይ ሽያጭ ድምር:'),
              pw.Text(
                  NumberFormat.currency(locale: 'en_US', symbol: 'ETB ').format(
                showSales ? totalSales : 0,
              )),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('አጠቃላይ ወጪ ድምር:'),
              pw.Text(
                  NumberFormat.currency(locale: 'en_US', symbol: 'ETB ').format(
                showSales ? 0 : totalExpenses,
              )),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('ቀሪ:'),
              pw.Text(
                  NumberFormat.currency(locale: 'en_US', symbol: 'ETB ').format(
                    netAmount,
                  ),
                  style: pw.TextStyle(
                      color:
                          (netAmount >= 0 ? PdfColors.green : PdfColors.red))),
            ],
          ),
        ],
      );

      final outputFile = await getExternalStorageDirectory();
      final file = File('${outputFile!.path}/$fileName');

      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF exported successfully to ${file.path}')),
      );
    } catch (e) {
      print('Error saving PDF file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file: $e')),
      );
    }
  }
}
