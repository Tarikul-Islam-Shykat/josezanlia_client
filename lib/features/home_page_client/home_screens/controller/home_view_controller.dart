import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';

import '../../../../core/global_widegts/custom_snack_bar.dart';
import '../../../../core/repository/network_caller/endpoints.dart';
import '../../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../model/get_my_profile.dart';

class WaterBillController extends GetxController {
  //final RxString userName = 'Adam'.obs;
  final RxString meterNumber = 'A73353'.obs;
  final Rx<DateTime> expiryDate = DateTime(2025, 4, 4).obs;
  final RxDouble penaltyCharge = 50.0.obs;
  final RxString currency = 'MZN'.obs;

  final RxDouble currentReading = 44.22.obs;
  final RxDouble lastMonthReading = 50.22.obs;
  final RxDouble pricePerUnit = 70.0.obs;
  final RxDouble minimumFee = 300.0.obs;
  final RxDouble totalBill = 200.0.obs;
  final RxString billStatus = 'DUE'.obs;


  final isFetchUserDataLoading = false.obs;
  final _networkConfig = NetworkConfig();
  RxString userProfileImage = ''.obs;
  RxString userWorkerId = ''.obs;
  RxString userName = ''.obs;

  final RxList recentPayments =
      [
        {
          'provider': 'ComunAgua Water Bill',
          'date': DateTime(2025, 7, 4),
          'status': 'Paid',
        },
      ].obs;

  final RxInt notificationCount = 2.obs;


  @override
  void onInit() {

    if (kDebugMode) {
      print("WrHomeController initialized");
    }


    fetchUserProfile();
    super.onInit();
  }

  void saveDataAtSharedPref({
    String userProfileImage = '',
    String userFirstName = '',
    String userLastName = '',
    String userPhoneNumber = '',
    String userWorkerId = '',
  }) async {
    if (kDebugMode) {
      print("Saidi Image: ${userProfileImage}");
      print("Saidi Worker ID: ${userWorkerId}");
      print("Saidi First Name: ${userFirstName}");
      print("Saidi Last Name: ${userLastName}");
      print("Saidi Phone Number: ${userPhoneNumber}");
      print("Saidi Worker Id: ${userWorkerId}");
    }

    await SharedPreferencesHelper.saveUserProfileImage(userProfileImage);
    await SharedPreferencesHelper.saveUserFirstName(userFirstName);
    await SharedPreferencesHelper.saveUserLastName(userLastName);
    await SharedPreferencesHelper.saveUserPhoneNumber(userPhoneNumber);
    await SharedPreferencesHelper.saveUserWorkerId(userWorkerId);





    if (kDebugMode) {
      print(
        "User Profile Image At Home Controller: ${await SharedPreferencesHelper.getUserProfileImage()}",
      );
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      isFetchUserDataLoading.value = true;

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getMe,
        null,
        is_auth: true,
      );

      if (kDebugMode) {
        print("User profile API response: $response");
      }

      if (response != null && response['success'] == true) {
        showSnackBar(true, response['message']);

        final profileData = GetMyProfile.fromJson(response);

        if (kDebugMode) {
          print("ProfileData: $profileData");
          print("Profile Data Email: ${profileData.data?.email ?? ''}");
          // print(
          //   "Profile Data Worker Id: ${profileData.data?.worker?[0].workerId ?? ''}",
          // );
          // print(
          //   "Profile Data Worker Id manual: ${response['data']['worker'][0]['workerId']}",
          // );

          if (profileData.data?.worker != null &&
              profileData.data!.worker!.isNotEmpty) {
            print(
              "Profile Data Worker Id: ${profileData.data!.worker![0].workerId ?? ''}",
            );
          } else {
            print("No worker data available");
          }
        }


        if (kDebugMode) {
          print("Print Image: ${profileData.data?.profileImage ?? ''}");
        }

        if (profileData.data?.worker != null &&
            profileData.data!.worker!.isNotEmpty) {
          saveDataAtSharedPref(
            userProfileImage: profileData.data?.profileImage ?? '',
            userWorkerId: profileData.data?.worker?[0].workerId ?? '',
            userFirstName: profileData.data?.worker?[0].firstName ?? '',
            userLastName: profileData.data?.worker?[0].lastName ?? '',
            userPhoneNumber: profileData.data?.phone ?? '',
          );

          userName.value = profileData.data?.worker?[0].firstName ?? '';
          userProfileImage.value = profileData.data?.profileImage ?? '';
          userWorkerId.value = profileData.data?.worker?[0].workerId ?? '';





        } else {
          saveDataAtSharedPref(
            userProfileImage: profileData.data?.profileImage ?? '',
            userWorkerId: '',
            userFirstName: '',
            userLastName: '',
            userPhoneNumber: profileData.data?.phone ?? '',
          );

          userName.value = '';
          userProfileImage.value = profileData.data?.profileImage ?? '';
          userWorkerId.value = '';



        }
      } else {
        showSnackBar(false, response?['message'] ?? 'Unknown error');
      }
    } catch (e) {
      showSnackBar(false, "Catch Error: ${e.toString()}");
    } finally {
      isFetchUserDataLoading.value = false;
    }
  }











}
