import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/add_to_cart.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.image,
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description ?? '',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addToCart(context, product);
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void addToCart(BuildContext context, Product product) {
    // Add the product to the cart
    AddToCart.addToCart(product);

    final snackBar = SnackBar(
      content: Text('Added ${product.title} to cart.'),
      action: SnackBarAction(
        label: 'View Cart',
        onPressed: () {
          // Navigate to the cart screen when the "View Cart" button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        },
      ),
    );

    // Show a snackbar notification with an option to view the cart
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
