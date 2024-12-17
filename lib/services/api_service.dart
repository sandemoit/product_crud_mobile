import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.102:3000/api/v1';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if(response.statusCode != 201) {
      throw Exception('Filed to create product');
    }
  }

  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if(response.statusCode != 200) {
      throw Exception('Filed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

    if(response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}