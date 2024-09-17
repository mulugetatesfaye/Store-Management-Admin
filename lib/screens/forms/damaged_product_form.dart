import 'package:ahmedadmin/models/damaged_product.dart';
import 'package:ahmedadmin/services/damaged_product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DamagedProductForm extends ConsumerStatefulWidget {
  const DamagedProductForm({super.key});

  @override
  _DamagedProductFormState createState() => _DamagedProductFormState();
}

class _DamagedProductFormState extends ConsumerState<DamagedProductForm> {
  final _formKey = GlobalKey<FormState>();
  final DamagedProductService _service = DamagedProductService();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  String? _selectedProductId;
  String? _selectedProductName;
  bool _isLoading = false;

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || _selectedProductId == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final quantity = int.parse(_quantityController.text.trim());

      // Get the product reference
      final productRef = FirebaseFirestore.instance
          .collection('products')
          .doc(_selectedProductId);

      // Fetch the current stock for the selected product and product name
      final productSnapshot = await productRef.get();
      final currentStock = productSnapshot['stock'] as int? ?? 0;
      final productName = productSnapshot['name'] as String? ?? 'Unknown';

      // Check if the damaged quantity is less than or equal to the current stock
      if (quantity > currentStock) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Insufficient stock available to report damage.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Create a new damaged product entry
      final damagedProductId = const Uuid().v4();
      final damagedProduct = DamagedProduct(
        damagedProductId: damagedProductId,
        productName: productName, // Save the product name here
        quantity: quantity,
        reason: _reasonController.text.trim(),
        reportedAt: DateTime.now(),
      );

      // Save the damaged product
      await _service.addDamagedProduct(damagedProduct);

      // Update the product stock by subtracting the damaged quantity
      await productRef.update({
        'stock': currentStock - quantity,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Damaged product recorded and stock updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildDropdownProductSelector() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final productDocs = snapshot.data?.docs ?? [];
        if (productDocs.isEmpty) {
          return const Text('No products available');
        }

        return DropdownButtonFormField<String>(
          value: _selectedProductId,
          decoration: InputDecoration(
            labelText: 'የተበላሸ እቃ ምረጥ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items: productDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return DropdownMenuItem<String>(
              value: doc.id,
              child: Text(data['name'] ?? 'Unknown'),
            );
          }).toList(),
          onChanged: (value) async {
            setState(() {
              _selectedProductId = value;
            });
            if (value != null) {
              // Fetch the product name when a product is selected
              final productRef =
                  FirebaseFirestore.instance.collection('products').doc(value);
              final productSnapshot = await productRef.get();
              setState(() {
                _selectedProductName = productSnapshot['name'] as String?;
              });
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a product';
            }
            return null;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('የተበላሸ እቃ'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDropdownProductSelector(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'የተበላሸ ብዛት',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'ምክንያት አስገባ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reason';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: !_isLoading ? _submitForm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'አስገባ',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
