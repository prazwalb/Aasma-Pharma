import 'package:intl/intl.dart';

class PFormater {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyy').format(date);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '+977 ${phoneNumber.substring(0, 9)}';
    } else if (phoneNumber.length != 10) {
      return 'invalid number';
    }
    return phoneNumber;
  }
}
