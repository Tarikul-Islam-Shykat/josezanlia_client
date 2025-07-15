import 'dart:developer';
import 'package:get/get.dart';
import 'package:prettyrini/features/auth_screen/screens/login_screen.dart';

import '../../../core/global_widegts/app_snackbar.dart';
import '../../../core/repository/network_caller/endpoints.dart';
import '../../../core/repository/network_caller/network_config.dart';
import '../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../model/user_info_model.dart';

class UserProfileController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  Rx<UserProfileModel> userProfile = UserProfileModel().obs;
  RxBool isLoading = false.obs;
  @override
  onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<bool> fetchUserProfile() async {
    isLoading.value = true;
    try {
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getMe,
        {},
        is_auth: true,
      );

      if (response != null && response["success"] == true) {
        userProfile.value = UserProfileModel.fromJson(response["data"]);

        await SharedPreferencesHelper.saveUserWorkerId(userProfile.value.consumer?[0].userId ?? '');


        log("User profile fetched successfully");
        return true;
      } else {
        log("Failed to fetch profile: ${response["message"]}");
        return false;
      }
    } catch (e) {
      log("Error in fetchUserProfile: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await SharedPreferencesHelper.clearAllData();
    Get.offAll(() => LoginScreen());
    AppSnackbar.show(
      message: 'you_have_been_logged_out_successfully'.tr,
      isSuccess: true,
    );
  }
}
