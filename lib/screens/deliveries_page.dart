import 'package:ahmedadmin/models/delivery.dart';
import 'package:ahmedadmin/screens/delivery_detail_page.dart';
import 'package:ahmedadmin/screens/forms/delivery_form.dart';
import 'package:ahmedadmin/services/delivery_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveriesListPage extends StatefulWidget {
  const DeliveriesListPage({super.key});

  @override
  _DeliveriesListPageState createState() => _DeliveriesListPageState();
}

class _DeliveriesListPageState extends State<DeliveriesListPage> {
  final DeliveryService _deliveryService = DeliveryService();
  String _selectedStatus = 'All';

  Future<void> _updateDeliveryStatus(
      String deliveryId, String newStatus) async {
    try {
      final delivery = await _deliveryService.getDelivery(deliveryId);
      if (delivery != null) {
        final updatedDelivery = delivery.copyWith(status: newStatus);
        await _deliveryService.updateDelivery(updatedDelivery);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Delivery status updated to $newStatus'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      ChoiceChip(
                        label: const Text('ሁሉም'),
                        selected: _selectedStatus == 'All',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'All';
                          });
                        },
                        selectedColor: Colors.green.withOpacity(0.3),
                        backgroundColor: Colors.grey[200],
                      ),
                      ChoiceChip(
                        label: const Text('መንገድ ላይ'),
                        selected: _selectedStatus == 'On the way',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'On the way';
                          });
                        },
                        selectedColor: Colors.green.withOpacity(0.3),
                        backgroundColor: Colors.grey[200],
                      ),
                      ChoiceChip(
                        label: const Text('የገቡ'),
                        selected: _selectedStatus == 'Delivered',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'Delivered';
                          });
                        },
                        selectedColor: Colors.green.withOpacity(0.3),
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('deliveries')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final deliveries = snapshot.data?.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Delivery.fromJson(data)
                          .copyWith(deliveryId: doc.id);
                    }).where((delivery) {
                      return _selectedStatus == 'All' ||
                          delivery.status == _selectedStatus;
                    }).toList() ??
                    [];

                if (deliveries.isEmpty) {
                  return const Center(
                    child: Text(
                      'ለጊዜው ምንም የጫነ መኪና የለም',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: deliveries.length,
                  itemBuilder: (context, index) {
                    final delivery = deliveries[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DeliveryDetailPage(delivery: delivery),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        leading: const Icon(
                          Icons.drive_eta_rounded,
                          size: 30,
                          color: Colors.blue,
                        ),
                        title: Text(
                          delivery.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          'ታርጋ: ${delivery.licenseNumber}\nስልክ: ${delivery.contactInfo}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        trailing: DropdownButton<String>(
                          value: delivery.status,
                          items: const [
                            DropdownMenuItem(
                              value: 'Pending',
                              child: Text('ሁሉም'),
                            ),
                            DropdownMenuItem(
                              value: 'On the way',
                              child: Text('መንገድ ላይ'),
                            ),
                            DropdownMenuItem(
                              value: 'Delivered',
                              child: Text('የገባ'),
                            ),
                          ],
                          onChanged: (status) {
                            if (status != null) {
                              _updateDeliveryStatus(
                                  delivery.deliveryId, status);
                            }
                          },
                          underline: const SizedBox.shrink(),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.teal),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DeliveryForm(),
            ),
          );
        },
        label: const Text('የጫነ መኪና አስገባ'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
