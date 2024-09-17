import 'package:ahmedadmin/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productServiceProvider = Provider((ref) => ProductService());

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> fetchProductNames() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => doc['name'] as String).toList();
  }

  Future<void> updateProductStock(
      String productName, int quantityChange) async {
    final productRef = _firestore.collection('products').doc(productName);

    return _firestore.runTransaction((transaction) async {
      final productSnapshot = await transaction.get(productRef);

      if (!productSnapshot.exists) {
        throw Exception('Product not found');
      }

      final currentStock = productSnapshot.data()?['stock'] ?? 0;
      final newStock = currentStock + quantityChange;

      if (newStock < 0) {
        throw Exception('Stock cannot be negative');
      }

      transaction.update(productRef, {'stock': newStock});
    });
  }

  Stream<List<Product>> getProducts() {
    return _firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data());
      }).toList();
    });
  }

  // Method to fetch a product by its ID
  Future<Product> getProductById(String productId) async {
    try {
      final docSnapshot =
          await _firestore.collection('products').doc(productId).get();

      if (docSnapshot.exists) {
        return Product.fromJson(docSnapshot.data()!);
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    try {
      // Reference to the product document
      final productRef = _firestore.collection('products').doc(productId);

      // Fetch the current document
      final productDoc = await productRef.get();

      if (!productDoc.exists) {
        throw Exception('Product not found');
      }

      // Update the quantity field
      await productRef.update({
        'stock': newQuantity,
      });
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      throw Exception('Failed to update product quantity: ${e.message}');
    } on Exception catch (e) {
      // Handle general errors
      throw Exception('Error: $e');
    }
  }

  Future<String?> getProductId() async {
    try {
      // Fetch product data; adjust the query as needed
      final productDoc = await _firestore
          .collection('products')
          .doc('productIdDocument')
          .get();
      if (productDoc.exists) {
        // Assuming productId is stored in the document; adjust as needed
        return productDoc.data()?['productId'] as String?;
      } else {
        print('No product found.');
        return null;
      }
    } catch (e) {
      print('Error fetching productId: $e');
      throw Exception('Failed to fetch product ID.');
    }
  }

  // Method to get products available for sale
  Stream<List<Product>> getProductsForSale() {
    return _firestore
        .collection('products')
        .where('stock', isGreaterThan: 0) // Only products with positive stock
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList(),
        );
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.productId)
          .update(product.toJson());
      print('Product updated successfully.');
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product data.');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      print('Product deleted successfully.');
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product.');
    }
  }
}
