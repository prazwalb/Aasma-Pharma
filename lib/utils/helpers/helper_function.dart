import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PHelperFunction {
  static Color? getColor(String color) {
    // define your product specific colors here and it will match the attribute color and show specific color

    if (color == "red") {
      return Colors.red;
    } else if (color == "blue") {
      return Colors.blue;
    } else if (color == "green") {
      return Colors.green;
    } else if (color == "yellow") {
      return Colors.yellow;
    } else if (color == "purple") {
      return Colors.purple;
    } else if (color == "orange") {
      return Colors.orange;
    } else if (color == "pink") {
      return Colors.pink;
    } else if (color == "brown") {
      return Colors.brown;
    } else if (color == "grey") {
      return Colors.grey;
    } else if (color == "black") {
      return Colors.black;
    } else if (color == "white") {
      return Colors.white;
    } else if (color == "cyan") {
      return Colors.cyan;
    } else if (color == "lime") {
      return Colors.lime;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }
}
