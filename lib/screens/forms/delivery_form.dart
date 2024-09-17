import 'package:ahmedadmin/models/delivery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class DeliveryForm extends ConsumerStatefulWidget {
  const DeliveryForm({super.key});

  @override
  _DeliveryFormState createState() => _DeliveryFormState();
}

class _DeliveryFormState extends ConsumerState<DeliveryForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _licenseNumberController;
  late TextEditingController _contactInfoController;
  late TextEditingController _productTypeController;
  late TextEditingController _productQuantityController;

  String _status = 'On the way'; // Default status
  bool _isLoading = false;
  DateTime? _selectedDate; // For holding the selected date

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _licenseNumberController = TextEditingController();
    _contactInfoController = TextEditingController();
    _productTypeController = TextEditingController();
    _productQuantityController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _licenseNumberController.dispose();
    _contactInfoController.dispose();
    _productTypeController.dispose();
    _productQuantityController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final deliveryId = const Uuid().v4();
      final delivery = Delivery(
        deliveryId: deliveryId,
        name: _nameController.text.trim(),
        licenseNumber: _licenseNumberController.text.trim(),
        contactInfo: _contactInfoController.text.trim(),
        status: _status,
        createdAt: _selectedDate ?? DateTime.now(), // Save the selected date
        productType: _productTypeController.text.trim(),
        productQuantity: int.parse(_productQuantityController.text.trim()),
      );

      await FirebaseFirestore.instance
          .collection('deliveries')
          .doc(deliveryId)
          .set(delivery.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delivery recorded successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(true);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unexpected error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('የጫነ መኪና አስገባ'),
        centerTitle: true,
        elevation: 0,
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
              _buildInputField(
                controller: _nameController,
                labelText: 'የሹፌሩ ስም',
                validator: (value) {
                  return null; // No validation needed for name
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _licenseNumberController,
                labelText: 'የታርጋ ቁጥር',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'እባክዎን የታርጋ ቁጥር አስገባ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _contactInfoController,
                labelText: 'ስልክ ቁጥር',
                validator: (value) {
                  return null; // No validation needed for contact info
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _productTypeController,
                labelText: 'የምርት አይነት',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'እባክዎን የምርት አይነት አስገባ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _productQuantityController,
                labelText: 'የምርት ብዛት',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'እባክዎን የምርት ብዛት አስገባ';
                  }
                  if (int.tryParse(value) == null) {
                    return 'እባክዎን ትክክለኛ ቁጥር አስገባ';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'መኪናው ደርሷል?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: ['On the way', 'Delivered'].map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'እባክዎን የማስተካከል ሁኔታ ምርጥ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _pickDate,
                child: Text(
                  _selectedDate == null
                      ? 'ቀን ምረጥ'
                      : 'ቀን: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                ),
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
                        'የጫነ መኪና አስገባ',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
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
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
