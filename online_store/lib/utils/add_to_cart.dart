import '../models/product.dart';

class AddToCart {
  static final List<Product> cartItems = [];

  static void addToCart(Product product) {
    cartItems.add(product);
  }

  static void removeFromCart(Product product) {
    cartItems.remove(product);
  }
}
