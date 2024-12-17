import 'package:flutter/material.dart';
import 'pages/product_list.dart';
import 'pages/product_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Home pada ProductListPage yang menampilkan daftar produk
      home: ProductListPage(),
      routes: {
        // Rute ke halaman tambah produk
        '/add-product': (context) => ProductFormPage(),
        '/edit-product': (context) => ProductFormPage(),
      },
    );
  }
}
