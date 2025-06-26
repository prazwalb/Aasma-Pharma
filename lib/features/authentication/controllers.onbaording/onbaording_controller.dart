import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// variables

  /// Update Current Index when page scroll
  void updatePageIndicator(index) {}

  ///  jumps to the specific dot selectedpage
  void dotNavigationClick(index) {}

  //  Updates current index & jump to next page
  void nextPage() {}

  //update current index & jump to the last page
  void skipPage() {}
}
