import 'package:android_std/features/screens/CateogryScreen.dart';
import 'package:android_std/features/shop/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:android_std/features/screens/PrescriptionScreen.dart';
import 'package:android_std/features/screens/chatbot.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.event_note_sharp),
              label: 'Prescription',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.category),
              label: 'Category',
            ),
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;

  final screens = [
    // PharmaHomePage(),
    // CategoryPage(),
    prescriptionScreen(),
    Cateogryscreen(),
    HomePage(),
    Chatbot(),
  ];
}





// import 'package:android_std/features/shop/cartPage.dart';
// import 'package:android_std/features/shop/homepage.dart';
// import 'package:android_std/features/shop/profile_Page.dart';
// import 'package:flutter/material.dart';

// class NavigationMenu extends StatefulWidget {
//   const NavigationMenu({super.key});

//   @override
//   State<NavigationMenu> createState() => _PharmaAppState();
// }

// class _PharmaAppState extends State<NavigationMenu> {
//   int _currentIndex = 0;
//   final List<CartItem> _cartItems = [];
//   final UserProfile _userProfile = UserProfile(
//     name: 'John Doe',
//     email: 'john.doe@email.com',
//     phone: '+1 234 567 8900',
//     address: '123 Main St, City, State 12345',
//     emergencyContact: '+1 234 567 8901',
//   );

//   void _addToCart(Medicine medicine) {
//     setState(() {
//       final existingItemIndex = _cartItems.indexWhere((item) => item.medicine.id == medicine.id);
      
//       if (existingItemIndex >= 0) {
//         _cartItems[existingItemIndex].quantity++;
//       } else {
//         _cartItems.add(CartItem(medicine: medicine));
//       }
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${medicine.name} added to cart'),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   void _removeFromCart(String medicineId) {
//     setState(() {
//       _cartItems.removeWhere((item) => item.medicine.id == medicineId);
//     });
//   }

//   void _updateCartQuantity(String medicineId, int quantity) {
//     setState(() {
//       final itemIndex = _cartItems.indexWhere((item) => item.medicine.id == medicineId);
//       if (itemIndex >= 0) {
//         if (quantity <= 0) {
//           _cartItems.removeAt(itemIndex);
//         } else {
//           _cartItems[itemIndex].quantity = quantity;
//         }
//       }
//     });
//   }

//   double get _cartTotal {
//     return _cartItems.fold(0.0, (total, item) => total + item.totalPrice);
//   }

//   int get _cartItemCount {
//     return _cartItems.fold(0, (total, item) => total + item.quantity);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> pages = [
//       HomePage(onAddToCart: _addToCart),
//       CartPage(
//         cartItems: _cartItems,
//         onRemoveFromCart: _removeFromCart,
//         onUpdateQuantity: _updateCartQuantity,
//         cartTotal: _cartTotal,
//       ),
//       ProfilePage(userProfile: _userProfile),
//     ];

//     return Scaffold(
//       body: pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue[600],
//         unselectedItemColor: Colors.grey,
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Stack(
//               children: [
//                 const Icon(Icons.shopping_cart),
//                 if (_cartItemCount > 0)
//                   Positioned(
//                     right: 0,
//                     top: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 12,
//                         minHeight: 12,
//                       ),
//                       child: Text(
//                         '$_cartItemCount',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 8,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             label: 'Cart',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }