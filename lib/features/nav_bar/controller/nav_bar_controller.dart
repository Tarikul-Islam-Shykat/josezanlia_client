// import 'package:get/get.dart';

// class NavBarController extends GetxController {

//   var selectedIndex = 0.obs;

//   void changeTab(int index) {
//     selectedIndex.value = index;
//   }
// }

import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
