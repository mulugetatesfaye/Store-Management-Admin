import 'package:ahmedadmin/models/delivery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createDelivery(Delivery delivery) async {
    try {
      await _firestore
          .collection('deliveries')
          .doc(delivery.deliveryId)
          .set(delivery.toJson());
      print('Delivery created successfully.');
    } catch (e) {
      print('Error creating delivery: $e');
      throw Exception('Failed to create delivery. Please try again.');
    }
  }

  Stream<List<Delivery>> getDeliveries() {
    return _firestore
        .collection('deliveries')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Delivery.fromJson(doc.data())).toList());
  }

  Future<Delivery?> getDelivery(String deliveryId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('deliveries').doc(deliveryId).get();
      if (doc.exists) {
        return Delivery.fromJson(doc.data()!);
      } else {
        print('Delivery not found.');
        return null;
      }
    } catch (e) {
      print('Error reading delivery: $e');
      throw Exception('Failed to fetch delivery data.');
    }
  }

  Future<void> updateDelivery(Delivery delivery) async {
    try {
      await _firestore
          .collection('deliveries')
          .doc(delivery.deliveryId)
          .update(delivery.toJson());
      print('Delivery updated successfully.');
    } catch (e) {
      print('Error updating delivery: $e');
      throw Exception('Failed to update delivery data.');
    }
  }

  Future<void> deleteDelivery(String deliveryId) async {
    try {
      await _firestore.collection('deliveries').doc(deliveryId).delete();
      print('Delivery deleted successfully.');
    } catch (e) {
      print('Error deleting delivery: $e');
      throw Exception('Failed to delete delivery.');
    }
  }
}
