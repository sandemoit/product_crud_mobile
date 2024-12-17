import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Product product;

  ProductEditPage({required this.product});

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final ApiService apiService = ApiService();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController stokController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    descriptionController = TextEditingController(text: widget.product.description);
    priceController = TextEditingController(text: widget.product.price.toString());
    stokController = TextEditingController(text: widget.product.stok.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: stokController, decoration: InputDecoration(labelText: 'Stok'), keyboardType: TextInputType.number),
            ElevatedButton(
              onPressed: () {
                final Product updatedProduct = Product(
                  id: widget.product.id,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                  stok: double.parse(stokController.text),
                );
                apiService.updateProduct(updatedProduct); // Assuming you have an update method in your ApiService
                Navigator.pop(context);
              },child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stokController.dispose();
    super.dispose();
  }
}