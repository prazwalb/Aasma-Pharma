
import 'package:get/get.dart';

class DealItem {
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  int qty;

  DealItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.qty = 0,
  });
}

class CategoryItem {
  final String title;
  final String imageUrl;

  CategoryItem({
    required this.title,
    required this.imageUrl,
  });
}

class HomeController extends GetxController {
  var deals = <DealItem>[
    DealItem(
      name: "Zippigo-S Ointment",
      imageUrl: 'https://via.placeholder.com/100x80?text=Zippigo',
      price: 200,
      description: "Mometasone Furoate and Salicylic Acid - 15 gm",
    ),
    DealItem(
      name: "Odomos",
      imageUrl: 'https://via.placeholder.com/100x80?text=Odomos',
      price: 150,
      description: "Mosquito Repellent Cream - 100 gm",
    ),
    DealItem(
      name: "Vaseline",
      imageUrl: 'https://via.placeholder.com/100x80?text=Vaseline',
      price: 100,
      description: "Petroleum Jelly - 100 gm",
    ),
    DealItem(
      name: "Phensedyl DX",
      imageUrl: 'https://via.placeholder.com/100x80?text=Phensedyl',
      price: 140,
      description: "Cough Syrup - 100 ml",
    ),
  ].obs;

  final categories = <String, List<CategoryItem>>{
    "Personal Cleanliness Products": [
      CategoryItem(title: "Soap", imageUrl: "https://via.placeholder.com/80x80?text=Soap"),
      CategoryItem(title: "Body Scrubs", imageUrl: "https://via.placeholder.com/80x80?text=Scrub"),
      CategoryItem(title: "Moisturizers", imageUrl: "https://via.placeholder.com/80x80?text=Moist"),
    ],
    "Female Hygiene Products": [
      CategoryItem(title: "Sanitary Pads", imageUrl: "https://via.placeholder.com/80x80?text=Pads"),
      CategoryItem(title: "Intimate Wipes", imageUrl: "https://via.placeholder.com/80x80?text=Wipes"),
      CategoryItem(title: "Menstrual Cups", imageUrl: "https://via.placeholder.com/80x80?text=Cup"),
    ],
    "Baby Products": [
      CategoryItem(title: "Wet Wipes", imageUrl: "https://via.placeholder.com/80x80?text=Wipes"),
      CategoryItem(title: "Diapers", imageUrl: "https://via.placeholder.com/80x80?text=Diaper"),
      CategoryItem(title: "Baby Shampoos", imageUrl: "https://via.placeholder.com/80x80?text=Shampoo"),
    ],
    "Male Hygiene Products": [],
    "Medical Appliances": [],
    "First Aid & Wound care Products": [],
    "Contraceptive Products (Male & Female)": [],
  }.obs;

  void increaseQty(int index) {
    deals[index].qty++;
    deals.refresh();
  }

  void decreaseQty(int index) {
    if (deals[index].qty > 0) {
      deals[index].qty--;
      deals.refresh();
    }
  }
}
