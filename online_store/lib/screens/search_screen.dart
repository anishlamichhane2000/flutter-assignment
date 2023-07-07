import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/screens/product_screen_page.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';

class SearchScreen extends StatelessWidget {
  final ProductController productController;

  const SearchScreen({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            productController.searchProducts(value);
          },
        ),
      ),
      body: Obx(() {
        if (productController.searchResults.isEmpty) {
          return const Center(child: Text('No Results'));
        } else {
          return ListView.builder(
            itemCount: productController.searchResults.length,
            itemBuilder: (context, index) {
              Product product = productController.searchResults[index];
              return ListTile(
                leading: Image.network(product.image),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  navigateToProductDetail(product);
                },
              );
            },
          );
        }
      }),
    );
  }

  void navigateToProductDetail(Product product) {
    Get.to(ProductDetailScreen(product: product));
  }
}
