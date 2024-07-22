import 'package:flutter/material.dart';
import 'package:infoware/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.image ?? ''),
              const SizedBox(height: 16),
              Text(product.title ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('\$${product.price?.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              Text(product.description ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
