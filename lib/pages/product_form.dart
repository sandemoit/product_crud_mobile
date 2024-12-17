import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class ProductFormPage extends StatelessWidget {
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        iconTheme: IconThemeData(color: Colors.black), // Change back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align form fields to the left
          children: [
            _buildTextField(nameController, 'Name'),
            SizedBox(height: 16.0),
            _buildTextField(descriptionController, 'Description'),
            SizedBox(height: 16.0),
            _buildTextField(priceController, 'Price', keyboardType: TextInputType.number),
            SizedBox(height: 16.0),
            _buildTextField(stokController, 'Stok', keyboardType: TextInputType.number),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded button
                  ),
                ),
                onPressed: () async {
                  final Product product = Product(
                    id: 0, // Backend will set the ID
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                    stok: double.parse(stokController.text),
                  );
                  await apiService.createProduct(product);
                  Navigator.pop(context, product); // Return to the previous page
                },
                child: Text(
                  'Add Product',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700), // Softer label color
        filled: true,
        fillColor: Colors.grey.shade100, // Light background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none, // No border for a clean look
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Consistent padding
      ),
    );
  }
}
