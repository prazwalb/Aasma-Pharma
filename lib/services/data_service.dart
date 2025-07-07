import 'dart:convert';
import 'package:android_std/features/models/category.dart';
import 'package:android_std/features/models/product.dart';
import 'package:flutter/services.dart' show rootBundle;


// General categories for homepage
 Future<List<Category>> getGeneralCategories() async {
  try {
    final String response = await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> data = json.decode(response);
    final allCategories = data.map((json) => Category.fromJson(json)).toList();
    return allCategories.where((category) => category.type == 'general').toList();
  } catch (e) {
    return _getMockGeneralCategories();
  }
}

// Medicine categories for categories page
 Future<List<Category>> getMedicineCategories() async {
  try {
    final String response = await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> data = json.decode(response);
    final allCategories = data.map((json) => Category.fromJson(json)).toList();
    return allCategories.where((category) => category.type == 'medicine').toList();
  } catch (e) {
    return _getMockMedicineCategories();
  }
}

// Mock data for general categories
 List<Category> _getMockGeneralCategories() {
  return [
    Category(
      id: '1',
      name: 'First Aid',
      type: 'general',
      image: 'https://via.placeholder.com/150x150/ff4444/ffffff?text=First+Aid',
      description: 'Essential first aid supplies',
      products: [
        Product(
          id: '1',
          name: 'Bandages',
          image: 'https://via.placeholder.com/150x150/ff4444/ffffff?text=Bandages',
          price: 12.99,
          description: 'Adhesive bandages pack',
          categoryId: '1',
        ),
        Product(
          id: '2',
          name: 'Antiseptic',
          image: 'https://via.placeholder.com/150x150/ff4444/ffffff?text=Antiseptic',
          price: 8.99,
          description: 'Antiseptic solution',
          categoryId: '1',
        ),
      ],
    ),
    Category(
      id: '2',
      name: 'Feminine Hygiene',
      type: 'general',
      image: 'https://via.placeholder.com/150x150/ff69b4/ffffff?text=Feminine',
      description: 'Women\'s health and hygiene products',
      products: [
        Product(
          id: '3',
          name: 'Sanitary Pads',
          image: 'https://via.placeholder.com/150x150/ff69b4/ffffff?text=Pads',
          price: 15.99,
          description: 'Ultra-thin sanitary pads',
          categoryId: '2',
        ),
        Product(
          id: '4',
          name: 'Tampons',
          image: 'https://via.placeholder.com/150x150/ff69b4/ffffff?text=Tampons',
          price: 13.99,
          description: 'Organic cotton tampons',
          categoryId: '2',
        ),
      ],
    ),
    Category(
      id: '3',
      name: 'Baby Care',
      type: 'general',
      image: 'https://via.placeholder.com/150x150/87ceeb/ffffff?text=Baby',
      description: 'Baby care essentials',
      products: [
        Product(
          id: '5',
          name: 'Baby Diapers',
          image: 'https://via.placeholder.com/150x150/87ceeb/ffffff?text=Diapers',
          price: 24.99,
          description: 'Soft and absorbent diapers',
          categoryId: '3',
        ),
        Product(
          id: '6',
          name: 'Baby Lotion',
          image: 'https://via.placeholder.com/150x150/87ceeb/ffffff?text=Lotion',
          price: 9.99,
          description: 'Gentle baby lotion',
          categoryId: '3',
        ),
      ],
    ),
  ];
}

// Mock data for medicine categories
 List<Category> _getMockMedicineCategories() {
  return [
    Category(
      id: '4',
      name: 'Narcotics and Poisonous',
      type: 'medicine',
      image: 'https://via.placeholder.com/150x150/ff0000/ffffff?text=Narcotics',
      description: 'Controlled substances requiring special handling',
      products: [
        Product(
          id: '7',
          name: 'Controlled Medicine A',
          image: 'https://via.placeholder.com/150x150/ff0000/ffffff?text=Medicine+A',
          price: 89.99,
          description: 'Prescription required',
          categoryId: '4',
        ),
        Product(
          id: '8',
          name: 'Controlled Medicine B',
          image: 'https://via.placeholder.com/150x150/ff0000/ffffff?text=Medicine+B',
          price: 129.99,
          description: 'Prescription required',
          categoryId: '4',
        ),
      ],
    ),
    Category(
      id: '5',
      name: 'Prescriptive',
      type: 'medicine',
      image: 'https://via.placeholder.com/150x150/ffa500/ffffff?text=Prescriptive',
      description: 'Prescription medicines',
      products: [
        Product(
          id: '9',
          name: 'Antibiotic',
          image: 'https://via.placeholder.com/150x150/ffa500/ffffff?text=Antibiotic',
          price: 45.99,
          description: 'Prescription antibiotic',
          categoryId: '5',
        ),
        Product(
          id: '10',
          name: 'Blood Pressure Medicine',
          image: 'https://via.placeholder.com/150x150/ffa500/ffffff?text=BP+Med',
          price: 35.99,
          description: 'Prescription blood pressure medication',
          categoryId: '5',
        ),
      ],
    ),
    Category(
      id: '6',
      name: 'Non-Prescriptive',
      type: 'medicine',
      image: 'https://via.placeholder.com/150x150/00aa00/ffffff?text=Non-Prescriptive',
      description: 'Over-the-counter medicines',
      products: [
        Product(
          id: '11',
          name: 'Paracetamol',
          image: 'https://via.placeholder.com/150x150/00aa00/ffffff?text=Paracetamol',
          price: 5.99,
          description: 'Pain relief tablets',
          categoryId: '6',
        ),
        Product(
          id: '12',
          name: 'Cough Syrup',
          image: 'https://via.placeholder.com/150x150/00aa00/ffffff?text=Cough+Syrup',
          price: 12.99,
          description: 'Cough relief syrup',
          categoryId: '6',
        ),
        Product(
          id: '13',
          name: 'Vitamin C',
          image: 'https://via.placeholder.com/150x150/00aa00/ffffff?text=Vitamin+C',
          price: 18.99,
          description: 'Vitamin C supplements',
          categoryId: '6',
        ),
      ],
    ),
  ];
}

  //  Future<List<Product>> getProductsByCategory(String categoryId) async {
  //   final categories = await getCategories();
  //   final category = categories.firstWhere((cat) => cat.id == categoryId);
  //   return category.products;
  // }
