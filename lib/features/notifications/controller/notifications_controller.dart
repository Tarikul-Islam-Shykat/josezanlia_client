import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';


import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  int get unreadCount => notifications.where((n) => n.read == false).length;

  @override
  onInit(){
    super.onInit();
    getAllNotification();
    readNotification();

  }

  Future<bool> getAllNotification()async{
    isLoading.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(RequestMethod.GET, Urls.getNotifications,
          {},is_auth: true,
      );
      if(response != null && response["success"] == true){
        notifications.value = List<NotificationModel>.from(response["data"].map((e) => NotificationModel.fromJson(e)));
        log("${response["message"]}");
        return true;
      }else{
        log("${response["message"]}");
        return false;
      }
    }catch(e){
      log("Response  Notification Failed: ${e.toString()}");
      return false;
    }finally{
      isLoading.value = false;
    }
  }


  Future<bool> readNotification()async{
    isLoading.value = true;
    try{
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.PATCH,
        Urls.readNotifications,
       jsonEncode({}) ,
        is_auth: true,);
      if(response != null && response["success"] == true){
        log("read notification success ${response["message"]}");
        return true;
      }else{
        log("read notification failed ${response["message"]}");
        return false;
      }
    }catch(e){
      log("Response failed ${e.toString()}");
      return false;
    }finally{
      isLoading.value = false;
    }
  }
}
