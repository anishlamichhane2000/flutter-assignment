import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/add_to_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AddToCart.cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Cart'),
        ),
        body: const Center(
          child: Text(
            'Cart is empty',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: AddToCart.cartItems.length,
        itemBuilder: (context, index) {
          final Product product = AddToCart.cartItems[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                removeFromCart(context, product);
              },
            ),
          );
        },
      ),
    );
  }

  void removeFromCart(BuildContext context, Product product) {
    AddToCart.removeFromCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${product.title} from cart.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            AddToCart.addToCart(product);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
