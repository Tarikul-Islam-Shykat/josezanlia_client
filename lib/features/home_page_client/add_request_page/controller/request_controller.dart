import 'package:get/get.dart';

// Controller for managing the selected tab
class TopUpController extends GetxController {
  var selectedTab = 'Add Request'.obs; // Initialize with 'Add Request'
  // RxString is used to make the variable observable

  void changeTab(String tabName) {
    selectedTab.value = tabName; // Update the selected tab
  }
}
