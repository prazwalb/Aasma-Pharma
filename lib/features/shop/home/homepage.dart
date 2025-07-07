import 'package:android_std/features/controllers/cart_controller.dart';
import 'package:android_std/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart';
import 'package:android_std/features/shop/cartPage.dart';
import 'package:android_std/productDetail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  late CartController _cartController;
   @override
  void initState() {
    super.initState();
    // Initialize CartController if it doesn't exist
    if (!Get.isRegistered<CartController>()) {
      _cartController = Get.put(CartController());
    } else {
      _cartController = Get.find<CartController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Aasma Pharma',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          // Replace the existing cart IconButton in the AppBar
          IconButton(
    icon: Stack(
      children: [
        Icon(Icons.shopping_cart, color: Colors.black),
        Obx(() {
          return _cartController.totalItems.value > 0
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartController.totalItems.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SizedBox();
        }),
      ],
    ),
    onPressed: () {
      Get.to(() => CartPage());
    },
  ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and Greeting Section
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Kathmandu, Nepal',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Good morning!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Banner/Deal Section
            Container(
              height: 160,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.green[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deal of the day',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Save up to 50%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'on health essentials',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Icon(
                      Icons.local_pharmacy,
                      color: Colors.white30,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),

            // Featured Products Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Product Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
                children: [
                  _buildProductCard(
                    'Paracetamol',
                    'Rs. 45',
                    'Rs. 60',
                    Icons.medication,
                    Colors.blue,
                    Image.asset(PImage.onBoardingImage1),
                  ),
                  _buildProductCard(
                    'Vitamin C',
                    'Rs. 120',
                    'Rs. 150',
                    Icons.healing,
                    Colors.orange,
                    Image.asset(PImage.onBoardingImage2),
                  ),
                  _buildProductCard(
                    'Hand Sanitizer',
                    'Rs. 80',
                    'Rs. 100',
                    Icons.sanitizer,
                    Colors.green,
                    Image.asset(PImage.onBoardingImage3),
                  ),
                  _buildProductCard(
                    'Face Mask',
                    'Rs. 25',
                    'Rs. 35',
                    Icons.masks,
                    Colors.purple,
                    Image.asset(PImage.onBoardingImage3),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Categories Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryCard(
                          'Personal Care & Hygiene Products',
                          Colors.pink[100]!,
                          Colors.pink[600]!,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryCard(
                          'Feminine Hygiene Products',
                          Colors.purple[100]!,
                          Colors.purple[600]!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryCard(
                          'Baby Products',
                          Colors.blue[100]!,
                          Colors.blue[600]!,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryCard(
                          'Home Care Products',
                          Colors.green[100]!,
                          Colors.green[600]!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryCard(
                          'Medical Equipment',
                          Colors.red[100]!,
                          Colors.red[600]!,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryCard(
                          'First Aid & Wound Care Products',
                          Colors.orange[100]!,
                          Colors.orange[600]!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Quick Services Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Quick Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 12),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickServiceCard(
                    'Upload Prescription',
                    Image.asset(PImage.onBoardingImage1),
                    Colors.blue,
                  ),
                  _buildQuickServiceCard(
                    'Find Nearby Pharmacy',
                    Image.asset(PImage.onBoardingImage2),
                    Colors.green,
                  ),
                  _buildQuickServiceCard(
                    'Order Tracking',
                    Image.asset(PImage.onBoardingImage3),
                    Colors.orange,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String title,
    String price,
    String originalPrice,
    IconData icon,
    Color color,
    Image image,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 100,
              width: 500,
              child: image,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Add to cart functionality can be implemented here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title added to cart')),
                  );
                  _cartController.addToCart(CartItem(name: title, price: price, originalPrice: originalPrice, imageUrl: image,quantity: 1,),);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 25,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      originalPrice,
                      style: TextStyle(
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

  Widget _buildCategoryCard(
    String title,
    Color backgroundColor,
    Color iconColor,
  ) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServiceCard(String title, Image imageUrl, Color color) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: imageUrl,
          ),

          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
