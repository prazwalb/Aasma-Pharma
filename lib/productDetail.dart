import 'package:android_std/features/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String price;
  final String originalPrice;
  final String details;
  final Image imageUrl;
  final int quantity;

  const ProductDetails({
    super.key,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.details,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}


class _ProductDetailsState extends State<ProductDetails> {
  late CartController _cartController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cartController= Get.find<CartController>();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildProductCard(
            widget.name,
            widget.price,
            widget.originalPrice,
            widget.details,
            widget.imageUrl,
            widget.quantity,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String name,
    String price,
    String originalPrice,
    String details,
    Image imageUrl,
    int quantity,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imageUrl.toString()),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(details),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added to cart')),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.add_shopping_cart, color: Colors.white),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
