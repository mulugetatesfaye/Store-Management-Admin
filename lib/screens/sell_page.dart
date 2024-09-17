import 'package:ahmedadmin/models/product.dart';
import 'package:ahmedadmin/models/sale.dart';
import 'package:ahmedadmin/screens/forms/sales_form.dart';
import 'package:ahmedadmin/services/product_service.dart';
import 'package:ahmedadmin/services/sales_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final SalesService _salesService = SalesService();
  final ProductService _productService = ProductService();
  String? _selectedProductId;
  List<Product> _products = [];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    _productService.getProducts().listen((products) {
      setState(() {
        _products = products;
      });
    });
  }

  Future<double> calculateNetSales() async {
    try {
      // Fetch all sales from Firestore
      final salesSnapshot =
          await FirebaseFirestore.instance.collection('sales').get();
      double totalSales = 0.0;
      for (var saleDoc in salesSnapshot.docs) {
        final saleData = saleDoc.data();
        totalSales +=
            saleData['totalPrice'] ?? 0.0; // Sum totalPrice for each sale
      }

      // Fetch all expenses from Firestore
      final expensesSnapshot =
          await FirebaseFirestore.instance.collection('expenses').get();
      double totalExpenses = 0.0;
      for (var expenseDoc in expensesSnapshot.docs) {
        final expenseData = expenseDoc.data();
        totalExpenses +=
            expenseData['amount'] ?? 0.0; // Sum amount for each expense
      }

      // Calculate net sales by subtracting total expenses from total sales
      double netSales = totalSales - totalExpenses;
      return netSales;
    } catch (e) {
      print('Error calculating net sales: $e');
      return 0.0; // Return 0 if an error occurs
    }
  }

  Future<double> calculateTotalSales() async {
    try {
      // Fetch all sales from Firestore
      final salesSnapshot =
          await FirebaseFirestore.instance.collection('sales').get();
      double totalSales = 0.0;
      for (var saleDoc in salesSnapshot.docs) {
        final saleData = saleDoc.data();
        totalSales +=
            saleData['totalPrice'] ?? 0.0; // Sum totalPrice for each sale
      }
      return totalSales;
    } catch (e) {
      print('Error calculating total sales: $e');
      return 0.0; // Return 0 if an error occurs
    }
  }

  Stream<List<Sale>> _getSalesStream() {
    Stream<List<Sale>> salesStream;

    if (_selectedProductId == null || _selectedProductId == 'All') {
      salesStream = _salesService.getSales();
    } else {
      salesStream = _salesService.getSalesByProductId(_selectedProductId!);
    }

    return salesStream.map((sales) => _filterSales(sales));
  }

  List<Sale> _filterSales(List<Sale> sales) {
    final now = DateTime.now();
    switch (_selectedFilter) {
      case 'Daily':
        return sales
            .where((sale) =>
                sale.saleDate.year == now.year &&
                sale.saleDate.month == now.month &&
                sale.saleDate.day == now.day)
            .toList();
      case 'Weekly':
        final lastWeek = now.subtract(const Duration(days: 7));
        return sales.where((sale) => sale.saleDate.isAfter(lastWeek)).toList();
      case 'Monthly':
        final lastMonth = now.subtract(const Duration(days: 30));
        return sales.where((sale) => sale.saleDate.isAfter(lastMonth)).toList();
      case 'All':
      default:
        return sales;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<double>(
              future: calculateTotalSales(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final netSales = snapshot.data ?? 0.0;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'አጠቃላይ ሽያጭ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                              .format(netSales),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            // Filter Chips
            Wrap(
              spacing: 8.0,
              children: ['All', 'Daily', 'Weekly', 'Monthly'].map((filter) {
                return ChoiceChip(
                  label: Text(filter),
                  selected: _selectedFilter == filter,
                  onSelected: (isSelected) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Sales List
            Expanded(
              child: StreamBuilder<List<Sale>>(
                stream: _getSalesStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final sales = snapshot.data!;

                  if (sales.isEmpty) {
                    return Center(
                      child: Text(
                        _selectedProductId == 'All' && _selectedFilter == 'All'
                            ? 'ለጊዜው ምንም የተሸጠ እቃ የለም.'
                            : 'ለጊዜው ምንም የተሸጠ እቃ የለም ${_selectedProductId != 'All' ? 'product' : 'filter'}.',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      final sale = sales[index];
                      return SoldTransactionCard(sale: sale);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SalesForm(),
          ));
        },
        label: const Text('ሽያጭ አስገባ'), // "Add Sale" in Amharic
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class SoldTransactionCard extends StatelessWidget {
  final Sale sale;

  const SoldTransactionCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: sale.imageUrls.isNotEmpty
              ? Image.network(
                  sale.imageUrls.first,
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
        title: Text(
          sale.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            'የተሸጠበት ቀን: ${DateFormat('M/d/yyyy').format(sale.saleDate)}'), // Format date as needed
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'የተሸጠ ብዛት: ${sale.quantity}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              NumberFormat.currency(locale: 'en_US', symbol: 'ETB ')
                  .format(sale.totalPrice),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 15),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
