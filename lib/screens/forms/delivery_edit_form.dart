import 'package:ahmedadmin/models/delivery.dart';
import 'package:ahmedadmin/services/delivery_service.dart';
import 'package:flutter/material.dart';

class DeliveryEditPage extends StatefulWidget {
  final Delivery delivery;

  const DeliveryEditPage({super.key, required this.delivery});

  @override
  _DeliveryEditPageState createState() => _DeliveryEditPageState();
}

class _DeliveryEditPageState extends State<DeliveryEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _licenseNumberController;
  late TextEditingController _contactInfoController;
  late TextEditingController _productTypeController;
  late TextEditingController _productQuantityController;
  String? _status;
  bool _isLoading = false;

  final List<String> _statusOptions = ['Pending', 'On the way', 'Delivered'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.delivery.name);
    _licenseNumberController =
        TextEditingController(text: widget.delivery.licenseNumber);
    _contactInfoController =
        TextEditingController(text: widget.delivery.contactInfo);
    _productTypeController =
        TextEditingController(text: widget.delivery.productType);
    _productQuantityController =
        TextEditingController(text: widget.delivery.productQuantity.toString());
    _status = widget.delivery.status;
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

  Future<void> _saveDelivery() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final updatedDelivery = widget.delivery.copyWith(
        name: _nameController.text,
        licenseNumber: _licenseNumberController.text,
        contactInfo: _contactInfoController.text,
        productType: _productTypeController.text,
        productQuantity: int.tryParse(_productQuantityController.text) ?? 0,
        status: _status ?? widget.delivery.status,
      );

      try {
        await DeliveryService().updateDelivery(updatedDelivery);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Delivery updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update delivery: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Delivery'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'የሹፌር ስም'),
                    validator: (value) => value?.isNotEmpty == true
                        ? null
                        : 'This field is required',
                  ),
                  TextFormField(
                    controller: _licenseNumberController,
                    decoration: const InputDecoration(labelText: 'የታርጋ ቁጥር'),
                    validator: (value) => value?.isNotEmpty == true
                        ? null
                        : 'This field is required',
                  ),
                  TextFormField(
                    controller: _contactInfoController,
                    decoration: const InputDecoration(labelText: 'ስልክ ቁጥር'),
                  ),
                  TextFormField(
                    controller: _productTypeController,
                    decoration: const InputDecoration(labelText: 'የምርት አይነት'),
                    validator: (value) => value?.isNotEmpty == true
                        ? null
                        : 'This field is required',
                  ),
                  TextFormField(
                    controller: _productQuantityController,
                    decoration: const InputDecoration(labelText: 'የምርት ብዛት'),
                    keyboardType: TextInputType.number,
                    validator: (value) => int.tryParse(value ?? '') != null
                        ? null
                        : 'Please enter a valid number',
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(labelText: 'ሁኔታ'),
                    items: _statusOptions.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                    validator: (value) =>
                        value != null ? null : 'This field is required',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveDelivery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text('Save Changes'),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
