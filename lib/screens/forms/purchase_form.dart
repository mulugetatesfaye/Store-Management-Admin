import 'dart:io';
import 'package:ahmedadmin/models/product.dart';
import 'package:ahmedadmin/models/purchase.dart';
import 'package:ahmedadmin/services/image_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({super.key});

  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _storeIdController = TextEditingController();
  final _supplierController = TextEditingController();

  bool _isLoading = false;
  String placeholderImageUrl = 'https://via.placeholder.com/150';
  File? selectedImage;

  final ImageService _imageService = ImageService();

  String? _selectedProduct;
  final List<String> _productOptions = [
    'ስኳር',
    'ዘይት(በካርቶን)',
    'ዘይት(በጀሪካን)',
    'ዱቄት',
    'ሩዝ'
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _storeIdController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final image = await _imageService.pickImage();
      if (image != null) {
        final compressedImage = await _imageService.compressImage(image);
        setState(() {
          selectedImage = compressedImage;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _savePurchase() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Upload the image and get the URL
      String imageUrl = placeholderImageUrl; // Default placeholder URL
      if (selectedImage != null) {
        try {
          imageUrl = await _imageService.uploadImage(selectedImage!);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error uploading image: $e')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      final double pricePerUnit =
          double.tryParse(_priceController.text.trim()) ?? 0.0;
      final int quantity = int.tryParse(_quantityController.text.trim()) ?? 0;

      try {
        // Run Firestore transaction
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final productQuery = await FirebaseFirestore.instance
              .collection('products')
              .where('name', isEqualTo: _selectedProduct)
              .limit(1)
              .get();

          if (productQuery.docs.isNotEmpty) {
            // Product exists, update the existing product
            final productRef = FirebaseFirestore.instance
                .collection('products')
                .doc(productQuery.docs.first.id);

            final existingProduct = productQuery.docs.first.data();
            final existingStock = existingProduct['stock'] ?? 0;
            final updatedStock = existingStock + quantity;

            transaction.update(productRef, {
              'stock': updatedStock,
              'price': pricePerUnit,
              'updatedAt': DateTime.now(),
            });

            // Create Purchase
            await _createOrUpdatePurchase(
                transaction, productQuery.docs.first.id, [imageUrl]);
          } else {
            // Product does not exist, create a new product
            final String productId = const Uuid().v4();
            final product = Product(
              productId: productId,
              name: _selectedProduct ?? '',
              price: pricePerUnit,
              stock: quantity,
              description: _descriptionController.text.trim(),
              imageUrls: [imageUrl], // Save image URLs here
              createdAt: DateTime.now().toUtc(),
            );

            final productRef = FirebaseFirestore.instance
                .collection('products')
                .doc(productId);
            transaction.set(productRef, product.toJson());

            // Create Purchase
            await _createOrUpdatePurchase(transaction, productId, [imageUrl]);
          }
        });

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ግዢ በተሳካ ተፈፅሟል!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _createOrUpdatePurchase(
      Transaction transaction, String productId, List<String>? imageUrl) async {
    final double pricePerUnit =
        double.tryParse(_priceController.text.trim()) ?? 0.0;
    final int quantity = int.tryParse(_quantityController.text.trim()) ?? 0;

    final purchaseDate = DateTime.now().toUtc();

    // Create a new purchase entry
    final purchase = Purchase(
      productName: _selectedProduct!,
      purchaseId: const Uuid().v4(),
      productId: productId,
      quantity: quantity,
      pricePerUnit: pricePerUnit,
      imageUrls: [],
      totalPrice: pricePerUnit * quantity,
      supplier: _supplierController.text.trim(),
      purchaseDate: purchaseDate,
    );

    final purchaseRef = FirebaseFirestore.instance
        .collection('purchases')
        .doc(purchase.purchaseId);
    transaction.set(purchaseRef, purchase.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ግዢ አስገባ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.only(top: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    child: selectedImage != null
                        ? Stack(
                            children: [
                              Positioned.fill(
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: FloatingActionButton(
                                  onPressed: _pickImage,
                                  mini: true,
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                ),
                                SizedBox(height: 10),
                                Text('የእቃ ምስል ይምረጡ'),
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedProduct,
                  items: _productOptions
                      .map((product) => DropdownMenuItem(
                          value: product, child: Text(product)))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'የምርት ስም',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? 'የእቃ ስም ይምረጡ' : null,
                  onChanged: (value) {
                    setState(() {
                      _selectedProduct = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                    controller: _descriptionController,
                    hintText: 'ተጨማሪ መግለጫ',
                    labelText: 'መግለጫ'),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _priceController,
                  hintText: 'የእቃው ዋጋ',
                  labelText: 'ዋጋ',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _quantityController,
                  hintText: 'የእቃው ብዛት',
                  labelText: 'ብዛት',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                const Divider(),
                ElevatedButton(
                  onPressed: _isLoading ? null : _savePurchase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'ግዢ አስገባ',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText ይሙሉ';
        }
        return null;
      },
    );
  }
}
