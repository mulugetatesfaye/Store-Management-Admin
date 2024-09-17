import 'package:ahmedadmin/models/sale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Sale>> getSales() {
    return _firestore
        .collection('sales')
        .orderBy('saleDate', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Sale.fromJson(doc.data())).toList());
  }

  // Get sales by product ID
  Stream<List<Sale>> getSalesByProductId(String productId) {
    return _firestore
        .collection('sales')
        .where('productId', isEqualTo: productId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Sale.fromJson(doc.data())).toList());
  }

  Future<void> createSale(Sale sale) async {
    try {
      await _firestore.collection('sales').doc(sale.saleId).set(sale.toJson());
      print('Sale created successfully.');
    } catch (e) {
      print('Error creating sale: $e');
      throw Exception('Failed to create sale. Please try again.');
    }
  }

  Future<Sale?> getSale(String saleId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('sales').doc(saleId).get();
      if (doc.exists) {
        return Sale.fromJson(doc.data()!);
      } else {
        print('Sale not found.');
        return null;
      }
    } catch (e) {
      print('Error reading sale: $e');
      throw Exception('Failed to fetch sale data.');
    }
  }

  Future<void> updateSale(Sale sale) async {
    try {
      await _firestore
          .collection('sales')
          .doc(sale.saleId)
          .update(sale.toJson());
      print('Sale updated successfully.');
    } catch (e) {
      print('Error updating sale: $e');
      throw Exception('Failed to update sale data.');
    }
  }

  Future<void> deleteSale(String saleId) async {
    try {
      await _firestore.collection('sales').doc(saleId).delete();
      print('Sale deleted successfully.');
    } catch (e) {
      print('Error deleting sale: $e');
      throw Exception('Failed to delete sale.');
    }
  }
}
