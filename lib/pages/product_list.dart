import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedProducts = await _apiService.fetchProducts();
      setState(() {
        _products = fetchedProducts;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products List', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white, // Flat app bar
        elevation: 0.0,
      ),
      body: _products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _fetchData,
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            return ProductCard(product: product);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade400,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, '/add-product'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for a modern feel
      ),
      elevation: 0, // Flat design, no shadow
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600, // Slightly less bold
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    currencyFormatter.format(product.price),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade600, // Softer color for price
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.grey.shade700),
              onPressed: () => Navigator.pushNamed(context, '/edit-product', arguments: product),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
              onPressed: () => _deleteProduct(product.id),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteProduct(int id) async {
    try {
      await ApiService().deleteProduct(id);
      // Refresh state or trigger data update
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }
}
