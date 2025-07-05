import 'package:get/get.dart';

class UserOnController extends GetxController {
  RxString selectedRole = 'user'.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }
}
