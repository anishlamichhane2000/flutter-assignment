import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_store/models/product.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<Product> searchResults = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        products.value = data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products');
    }
  }

  void searchProducts(String query) {
    searchResults.value = products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
