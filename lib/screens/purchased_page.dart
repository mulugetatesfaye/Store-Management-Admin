import 'package:ahmedadmin/models/product.dart';
import 'package:ahmedadmin/models/purchase.dart';
import 'package:ahmedadmin/screens/forms/purchase_form.dart';
import 'package:ahmedadmin/screens/purchase_detail_page.dart';
import 'package:ahmedadmin/services/product_service.dart';
import 'package:ahmedadmin/services/purchase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchasedPage extends StatefulWidget {
  const PurchasedPage({Key? key}) : super(key: key);

  @override
  State<PurchasedPage> createState() => _PurchasedPageState();
}

class _PurchasedPageState extends State<PurchasedPage> {
  final _productService = ProductService();
  final _purchaseService = PurchaseService();
  String? _selectedProductId;
  String _selectedFilter = 'ሁሉም'; // "All"
  List<Product> _products = [];

  Stream<List<Purchase>> _getPurchases() {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('purchases')
        .orderBy('purchaseDate', descending: true);

    if (_selectedProductId != null && _selectedProductId != 'ሁሉም') {
      query = query.where('productId', isEqualTo: _selectedProductId);
    }

    return query.snapshots().map((snapshot) {
      final purchases = snapshot.docs.map((doc) {
        final data = doc.data();
        final purchaseDate = _parseDate(data['purchaseDate']);
        return Purchase(
          purchaseId: data['purchaseId'] ?? '',
          productName: data['productName'] ?? '',
          productId: data['productId'] ?? '',
          quantity: data['quantity'] ?? 0,
          pricePerUnit: data['pricePerUnit'] ?? 0.0,
          totalPrice: data['totalPrice'] ?? 0.0,
          supplier: data['supplier'] ?? '',
          purchaseDate: purchaseDate,
        );
      }).toList();
      return _filterPurchases(purchases);
    });
  }

  DateTime _parseDate(dynamic dateField) {
    if (dateField is Timestamp) {
      return dateField.toDate();
    } else if (dateField is String) {
      return DateTime.tryParse(dateField) ?? DateTime(1970);
    } else if (dateField is DateTime) {
      return dateField;
    } else {
      return DateTime(1970);
    }
  }

  List<Purchase> _filterPurchases(List<Purchase> purchases) {
    final now = DateTime.now();

    switch (_selectedFilter) {
      case 'የዛሬ': // Today
        return purchases.where((purchase) {
          final purchaseDate = purchase.purchaseDate;
          return purchaseDate.year == now.year &&
              purchaseDate.month == now.month &&
              purchaseDate.day == now.day;
        }).toList();
      case 'የሳምንት': // Last Week
        final lastWeek = now.subtract(const Duration(days: 7));
        return purchases.where((purchase) {
          final purchaseDate = purchase.purchaseDate;
          return purchaseDate.isAfter(lastWeek);
        }).toList();
      case 'የወር': // Last Month
        final lastMonth = now.subtract(const Duration(days: 30));
        return purchases.where((purchase) {
          final purchaseDate = purchase.purchaseDate;
          return purchaseDate.isAfter(lastMonth);
        }).toList();
      case 'ሁሉም': // All
      default:
        return purchases;
    }
  }

  @override
  void initState() {
    super.initState();
    _productService.getProducts().listen((products) {
      setState(() {
        _products = products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Sales Display
            // StreamBuilder<List<Purchase>>(
            //   stream:
            //       _getPurchases(), // Ensure _getPurchases returns Stream<List<Purchase>>
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(
            //         child: Text('Error: ${snapshot.error}'),
            //       );
            //     }

            //     if (!snapshot.hasData) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }

            //     final sales = snapshot.data!;
            //     final totalSales = sales.fold<double>(
            //       0,
            //       (sum, purchase) => sum + purchase.totalPrice,
            //     );

            //     return Container(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            //       decoration: BoxDecoration(
            //         color: Colors.orange,
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.stretch,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const Text(
            //             'ጠቅላላ ግዢ',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           const SizedBox(height: 4),
            //           Text(
            //             NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
            //                 .format(totalSales),
            //             textAlign: TextAlign.center,
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 24,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 16),
            Expanded(child: _buildPurchasesList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PurchaseForm(),
          ));
        },
        label: const Text('ግዢ አስገባ'), // "Add Purchase"
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['ሁሉም', 'የዛሬ', 'የሳምንት', 'የወር'].map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: _selectedFilter == filter,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPurchasesList() {
    return StreamBuilder<List<Purchase>>(
      stream: _getPurchases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load purchases: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No purchases found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final purchase = snapshot.data![index];

            return SoldProductCard(
              purchase: purchase,
              onOrderPressed: () {
                // Add functionality for the order button if needed
              },
            );
          },
        );
      },
    );
  }
}

class SoldProductCard extends StatelessWidget {
  final Purchase purchase;
  final VoidCallback onOrderPressed;

  const SoldProductCard({
    Key? key,
    required this.purchase,
    required this.onOrderPressed,
  }) : super(key: key);

  DateTime _parseDate(dynamic dateField) {
    if (dateField is Timestamp) {
      return dateField.toDate();
    } else if (dateField is String) {
      return DateTime.tryParse(dateField) ?? DateTime(1970);
    } else if (dateField is DateTime) {
      return dateField;
    } else {
      return DateTime(1970);
    }
  }

  @override
  Widget build(BuildContext context) {
    final purchaseDate = _parseDate(purchase.purchaseDate);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: purchase.imageUrls != null && purchase.imageUrls!.isNotEmpty
              ? Image.network(
                  purchase.imageUrls!.first,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
                )
              : Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
        ),
        title: Text(purchase.productName),
        subtitle: Text('በ ${DateFormat.yMMMd().format(purchaseDate)}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'የተገዛው ብዛት: ${purchase.quantity}', // Changed to quantity
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                  .format(purchase.totalPrice), // Changed to totalPrice
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 15),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PurchaseDetailPage(
              purchased: purchase, // Pass purchase for detailed view
            ),
          ));
        },
      ),
    );
  }
}
