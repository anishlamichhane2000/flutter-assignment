import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/screens/product_screen_page.dart';
import 'package:online_store/screens/search_screen.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.amberAccent,
        title: const Text('Home page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.to(SearchScreen(productController: productController));
            },
          ),
        ],
      ),
      body: Obx(() {
        // Check if the product list is empty
        if (productController.products.isEmpty) {
          // Show a loading indicator if the list is empty
          return const Center(child: CircularProgressIndicator());
        } else {
          // Display the product list using ListView.builder
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              Product product = productController.products[index];
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
    // Navigate to the product detail screen
    Get.to(ProductDetailScreen(product: product));
  }
}
