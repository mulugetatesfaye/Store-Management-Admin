import 'package:ahmedadmin/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Assume Delivery is your model class for deliveries
class DeliveryTablePage extends StatelessWidget {
  final List<Delivery> deliveries;

  const DeliveryTablePage({
    super.key,
    required this.deliveries,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'መኪናዎች',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: deliveries.isEmpty
          ? const Center(
              child: Text(
                'ለጊዜው ምንም የጫነ መኪና የለም',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  headingRowHeight: 56.0,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'ስልክ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'የእቃው አይነት',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'የእቃው ብዛት',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ታርጋ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'የመኪናው ሁኔታ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ቀን',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    deliveries.length,
                    (index) {
                      final delivery = deliveries[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(delivery.contactInfo)),
                          DataCell(Text(delivery.productType)),
                          DataCell(Text('${delivery.productQuantity}')),
                          DataCell(Text(delivery.licenseNumber)),
                          DataCell(Text(delivery.status)),
                          DataCell(
                            Text(DateFormat('M/d/yyyy')
                                .format(delivery.createdAt)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
