import 'dart:developer';

import 'package:get/get.dart';
import 'dart:io';

class ProfileController extends GetxController {
  var userName = 'Michel Adam'.obs;
  var phoneNumber = '01813277700'.obs;
  var profileImage = Rxn<File>();

  void updateProfileImage(File image) {
    profileImage.value = image;
    log('Profile image updated: ${image.path}');
  }

  void updateProfile({String? name, String? phone}) {
    if (name != null && name.isNotEmpty) {
      userName.value = name;
    }
    if (phone != null && phone.isNotEmpty) {
      phoneNumber.value = phone;
    }
    log(
      'Profile updated - Name: ${userName.value}, Phone: ${phoneNumber.value}',
    );
  }
}
