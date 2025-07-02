import 'dart:developer';
import 'package:get/get.dart';
import '../../../../../core/repository/network_caller/network_config.dart';
import '../../../core/repository/network_caller/endpoints.dart';
import '../model/user_info_model.dart';

class UserProfileController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  Rx<UserProfileModel> userProfile = UserProfileModel().obs;
  RxBool isLoading = false.obs;
  @override
  onInit(){
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
}
