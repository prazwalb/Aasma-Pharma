import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String price;
  final String originalPrice;
  final Image imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get numericPrice => double.parse(price.replaceAll('Rs. ', ''));
  double get numericOriginalPrice => double.parse(originalPrice.replaceAll('Rs. ', ''));
}

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;
  
  List<CartItem> get cartItems => _cartItems;
  
  RxInt get totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity).obs;
  
  RxDouble get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + (item.numericPrice * item.quantity)).obs;
  
  RxDouble get totalSavings => _cartItems.fold(0.0, (sum, item) => 
      sum + ((item.numericOriginalPrice - item.numericPrice) * item.quantity)).obs;

  void addToCart(CartItem item) {
    final existingItemIndex = _cartItems.indexWhere((cartItem) => cartItem.name == item.name);
    
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity++;
    } else {
      _cartItems.add(item);
    }
    
  }

  void removeFromCart(String itemName) {
    _cartItems.removeWhere((item) => item.name == itemName);
  }

  void updateQuantity(String itemName, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemName);
      return;
    }
    
    final itemIndex = _cartItems.indexWhere((item) => item.name == itemName);
    if (itemIndex != -1) {
      _cartItems[itemIndex].quantity = newQuantity;
      _cartItems.refresh(); // Force UI update
    }
  }

  void incrementQuantity(String itemName) {
    final itemIndex = _cartItems.indexWhere((item) => item.name == itemName);
    if (itemIndex != -1) {
      _cartItems[itemIndex].quantity++;
      _cartItems.refresh();
    }
  }

  void decrementQuantity(String itemName) {
    final itemIndex = _cartItems.indexWhere((item) => item.name == itemName);
    if (itemIndex != -1) {
      if (_cartItems[itemIndex].quantity > 1) {
        _cartItems[itemIndex].quantity--;
        _cartItems.refresh();
      } else {
        removeFromCart(itemName);
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}