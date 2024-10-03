import 'package:covidapp/model.dart';
import 'package:covidapp/page2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // Sample product list
  final List<ProductModel> products = [
    ProductModel(
      title: "Product 1",
      description: "This is the description for product 1.",
      price: 29.99,
      imageUrl: "https://via.placeholder.com/150",
    ),
    ProductModel(
      title: "Product 2",
      description: "This is the description for product 2.",
      price: 39.99,
      imageUrl: "https://via.placeholder.com/150",
    ),
    ProductModel(
      title: "Product 3",
      description: "This is the description for product 3.",
      price: 49.99,
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];

  String? name1 = "fasfhfafhsoifhsoshfsao";
  String? name2 = "jasdfsdfklafasfs";
  String? name3 = "dflskfslfdsklfsfhskfhsfhshfhslhdfshlkhfl";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Use Expanded to avoid layout overflow issues
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return GestureDetector(
                      onTap: () {
                        // Navigate to Page2 with product details
                        Get.to(Page2(product: product));
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display product details
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(product.description),
                              const SizedBox(height: 5),
                              Text("\$${product.price.toString()}"),
                              const SizedBox(height: 10),
                              // Navigate using ElevatedButton
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(Page2(product: product));
                                },
                                child: const Text("Go to Page 2"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
