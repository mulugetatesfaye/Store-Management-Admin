import 'package:ahmedadmin/models/purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Purchase>> getPurchases() {
    return _db.collection('purchases').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Purchase.fromJson(doc.data())).toList());
  }

  Future<void> createPurchase(Purchase purchase) async {
    try {
      await _db
          .collection('purchases')
          .doc(purchase.purchaseId)
          .set(purchase.toJson());
      print('Purchase created successfully.');
    } catch (e) {
      print('Error creating purchase: $e');
      throw Exception('Failed to create purchase. Please try again.');
    }
  }

  Future<Purchase?> getPurchase(String purchaseId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _db.collection('purchases').doc(purchaseId).get();
      if (doc.exists) {
        return Purchase.fromJson(doc.data()!);
      } else {
        print('Purchase not found.');
        return null;
      }
    } catch (e) {
      print('Error reading purchase: $e');
      throw Exception('Failed to fetch purchase data.');
    }
  }

  Future<void> updatePurchase(Purchase purchase) async {
    try {
      await _db
          .collection('purchases')
          .doc(purchase.purchaseId)
          .update(purchase.toJson());
      print('Purchase updated successfully.');
    } catch (e) {
      print('Error updating purchase: $e');
      throw Exception('Failed to update purchase data.');
    }
  }

  Future<void> deletePurchase(String purchaseId) async {
    try {
      await _db.collection('purchases').doc(purchaseId).delete();
      print('Purchase deleted successfully.');
    } catch (e) {
      print('Error deleting purchase: $e');
      throw Exception('Failed to delete purchase.');
    }
  }
}
