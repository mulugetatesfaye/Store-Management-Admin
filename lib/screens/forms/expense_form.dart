import 'dart:io';
import 'package:ahmedadmin/models/expense.dart';
import 'package:ahmedadmin/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedType = 'የመኪና ኪራይ';
  bool _isSubmitting = false; // Tracks submission state
  final ImageService _imageService = ImageService();
  File? selectedImage;

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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true; // Show loading indicator
    });

    // Check if an image is selected before uploading
    String receiptImage = '';
    if (selectedImage != null) {
      try {
        receiptImage = await _imageService.uploadImage(selectedImage!);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
        setState(() {
          _isSubmitting = false;
        });
        return;
      }
    }

    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;
    final date = DateTime.now();
    final type = _selectedType;

    try {
      final expense = Expense(
          expenseId: FirebaseFirestore.instance.collection('expenses').doc().id,
          description: description,
          amount: amount,
          date: date,
          type: type,
          receiptImages: receiptImage.isNotEmpty ? [receiptImage] : []);

      await FirebaseFirestore.instance
          .collection('expenses')
          .doc(expense.expenseId)
          .set(expense.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(); // Go back to previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add expense: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false; // Hide loading indicator
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final initialDate = _selectedDate ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ወጪ'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'የመኪና ኪራይ', child: Text('የመኪና ኪራይ')),
                  DropdownMenuItem(value: 'ኮሚሽን', child: Text('ኮሚሽን')),
                  DropdownMenuItem(value: 'ለባንክ', child: Text('ለባንክ')),
                  DropdownMenuItem(
                      value: 'የሰራተኛ ክፍያ', child: Text('የሰራተኛ ክፍያ')),
                  DropdownMenuItem(value: 'CPO', child: Text('CPO')),
                  DropdownMenuItem(value: 'ትራንዚት', child: Text('ትራንዚት')),
                  DropdownMenuItem(value: 'ልዩ ወጪ', child: Text('ልዩ ወጪ')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _descriptionController,
                label: 'ዝርዝር',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _amountController,
                label: 'ብር',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text('ደረሰኝ አስገባ'),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'አስገባ',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      validator: validator,
    );
  }
}
