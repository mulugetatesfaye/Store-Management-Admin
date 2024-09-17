import 'dart:io';

import 'package:ahmedadmin/models/product.dart';
import 'package:ahmedadmin/models/sale.dart';
import 'package:ahmedadmin/services/image_service.dart';
import 'package:ahmedadmin/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SalesForm extends ConsumerStatefulWidget {
  const SalesForm({super.key});

  @override
  _SalesFormState createState() => _SalesFormState();
}

class _SalesFormState extends ConsumerState<SalesForm> {
  final _formKey = GlobalKey<FormState>();
  Product? selectedProduct;
  int quantity = 0;
  double pricePerUnit = 0.0;
  double paidAmount = 0.0;
  double remainingAmount = 0.0;
  double totalPrice = 0.0;

  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController paidAmountController;

  bool _isLoading = false;
  File? selectedImage;

  final ImageService _imageService = ImageService();

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController();
    priceController = TextEditingController();
    paidAmountController = TextEditingController();
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    paidAmountController.dispose();
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

  Future<void> _submitForm(ProductService productService) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Validate required fields
    // if (selectedImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please select an image.')),
    //   );
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   return;
    // }

    // Upload the image
    // String receiptImage;
    // try {
    //   receiptImage = await _imageService.uploadImage(selectedImage!);
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Error uploading image: $e')),
    //   );
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   return;
    // }

    try {
      final saleId = FirebaseFirestore.instance.collection('sales').doc().id;
      final updatedRemainingAmount = totalPrice - paidAmount;

      final sale = Sale(
        productName: selectedProduct!.name,
        saleId: saleId,
        productId: selectedProduct!.productId,
        quantity: quantity,
        pricePerUnit: pricePerUnit,
        totalPrice: totalPrice,
        paidAmount: paidAmount,
        remainingAmount: updatedRemainingAmount,
        soldBy: " ", // Replace with the actual cashier name
        saleDate: DateTime.now().toUtc(),
        imageUrls: selectedProduct?.imageUrls ?? [],
        receiptImages: [],
      );

      // Save sale to Firestore
      await FirebaseFirestore.instance
          .collection('sales')
          .doc(saleId)
          .set(sale.toJson());

      // Update product quantity in Firestore
      await productService.updateProductQuantity(
        selectedProduct!.productId,
        selectedProduct!.stock - quantity,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sale recorded successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(true);
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Handle general errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productService = ref.watch(productServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ሽያጭ ፈፅም'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamBuilder<List<Product>>(
                  stream: productService.getProductsForSale(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load products: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final products = snapshot.data ?? [];
                    if (products.isEmpty) {
                      return const Center(
                        child: Text(
                          'No products available for sale',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return DropdownButtonFormField<Product>(
                      decoration: InputDecoration(
                        labelText: 'የሚሸጥ እቃ ምረጥ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                      value: selectedProduct != null &&
                              products.contains(selectedProduct)
                          ? selectedProduct
                          : null,
                      items: products.map((product) {
                        return DropdownMenuItem<Product>(
                          value: product,
                          child: Text(product.name),
                        );
                      }).toList(),
                      onChanged: (Product? value) {
                        setState(() {
                          selectedProduct = value;
                          pricePerUnit = value?.price ?? 0.0;
                          totalPrice = quantity * pricePerUnit;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Divider(),
                if (selectedProduct != null) ...[
                  Text(
                    'የገባ ${selectedProduct!.name} ብዛት: ${selectedProduct!.stock}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: priceController,
                    labelText: 'የመሸጫ ዋጋ',
                    onChanged: (value) {
                      setState(() {
                        pricePerUnit = double.tryParse(value) ?? 0.0;
                        totalPrice = quantity * pricePerUnit;
                      });
                    },
                    validator: (value) {
                      final doubleValue = double.tryParse(value ?? '');
                      if (doubleValue == null || doubleValue <= 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: quantityController,
                    labelText: 'ብዛት',
                    onChanged: (value) {
                      setState(() {
                        quantity = int.tryParse(value) ?? 0;
                        totalPrice = quantity * pricePerUnit;
                      });
                    },
                    validator: (value) {
                      final intValue = int.tryParse(value ?? '');
                      if (intValue == null || intValue <= 0) {
                        return 'Please enter a valid quantity';
                      }
                      if (selectedProduct != null &&
                          intValue > selectedProduct!.stock) {
                        return 'Quantity exceeds available stock';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // GestureDetector(
                  //   onTap: _pickImage,
                  //   child: Container(
                  //     height: 120,
                  //     decoration: const BoxDecoration(
                  //       border: Border.fromBorderSide(
                  //         BorderSide(
                  //           style: BorderStyle.solid,
                  //           color: Colors.blue,
                  //         ),
                  //       ),
                  //     ),
                  //     child: (selectedProduct != null && selectedImage != null)
                  //         ? Stack(
                  //             children: [
                  //               Positioned.fill(
                  //                 child: Image.file(
                  //                   selectedImage!,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 bottom: 10,
                  //                 right: 10,
                  //                 child: FloatingActionButton(
                  //                   onPressed: _pickImage,
                  //                   mini: true,
                  //                   child: const Icon(Icons.edit),
                  //                 ),
                  //               ),
                  //             ],
                  //           )
                  //         : const Center(
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Icon(
                  //                   Icons.receipt,
                  //                   size: 40,
                  //                 ),
                  //                 SizedBox(height: 10),
                  //                 Text('ደረሰኝ አስገባ'),
                  //               ],
                  //             ),
                  //           ),
                  //   ),
                  // ),
                ],
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: selectedProduct != null && !_isLoading
                      ? () => _submitForm(productService)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'ድምር: ${NumberFormat.currency(locale: 'en_US', symbol: 'ETB ').format(totalPrice)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required ValueChanged<String> onChanged,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
