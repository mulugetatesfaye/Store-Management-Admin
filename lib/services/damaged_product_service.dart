import 'package:ahmedadmin/models/damaged_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DamagedProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDamagedProduct(DamagedProduct damagedProduct) async {
    try {
      await _firestore
          .collection('damaged_products')
          .doc(damagedProduct.damagedProductId)
          .set(damagedProduct.toJson());
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Stream<List<DamagedProduct>> getDamagedProductsStream() {
    return _firestore
        .collection('damaged_products')
        .orderBy('reportedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DamagedProduct.fromJson(doc.data()))
            .toList());
  }
}
