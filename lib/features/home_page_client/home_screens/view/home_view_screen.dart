import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_shimmer.dart';
import 'package:prettyrini/features/Home_page_client/Add_request_page/view/request_top_up_screen.dart';
import '../../../../core/global_widegts/custom_cached_image.dart';
import '../../../history/controller/history_controller.dart';
import '../../../history/view/history_view.dart';
import '../../../history/widget/history_item_tile.dart';
import '../../../notifications/controller/notifications_controller.dart';
import '../../../notifications/view/notifications_view.dart';
import '../../../profile/controller/user_info_controller.dart';
import '../controller/home_constroller.dart';
import '../model/get_all_reading_model.dart';

class WaterBillHome extends StatelessWidget {
  WaterBillHome({super.key});
  final ConsumerReadingController controller = Get.put(
    ConsumerReadingController(),
  );
  final UserProfileController userController = Get.put(UserProfileController());
  final NotificationController notificationController = Get.put(
    NotificationController(),
  );
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    // Data fetching should be handled before routing to home screen, during login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!userController.isLoading.value &&
          userController.userProfile.value.consumer != null &&
          userController.userProfile.value.consumer!.isNotEmpty) {
        final userId = userController.userProfile.value.consumer?.first.id;
        if (userId != null) {
          controller.getConsumerReadings(userId);
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Obx(() {
                  if (userController.isLoading.value) {
                    return boxShimmerPro(width: double.infinity, height: 100);
                  } else {
                    final data = userController.userProfile.value;
                    return Container(
                      margin: EdgeInsets.only(bottom: 400),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 50,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B3A3D),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomCachedImage(
                                imageUrl: data.profileImage.toString(),
                                type: CustomImageType.avatar,
                                radius: 25,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'hello'.tr +
                                        ', ${data.consumer!.first.firstName}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/balance.png',
                                          height: 22,
                                          width: 18,
                                        ),

                                        const SizedBox(width: 5),
                                        Text(
                                          '${data.consumer!.first.topUpBalance}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => NotificationsView())?.then((_) {
                                notificationController.readNotification();
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFE3E3E3,
                                    ).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Obx(() {
                                    final count =
                                        notificationController
                                            .notificationCount
                                            .value;
                                    if (count == 0) {
                                      return SizedBox.shrink(); // No badge if none unread
                                    }
                                    return Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF20800),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '$count',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),

                Obx(() {
                  if (controller.isLoading.value) {
                    return boxShimmerPro(width: Get.width, height: 100);
                  } else if (controller.readingList.isEmpty) {
                    return Positioned(
                      top: 135,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Text(
                          'no_billing_data'.tr,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    );
                  } else {
                    final data = controller.readingList[0];
                    return Positioned(
                      top: 135,
                      left: 20,
                      right: 20,
                      child: _buildCurrentBill(data),
                    );
                  }
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'recent_payment'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xF0000000),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => HistoryScreen()),
                    child: Text(
                      'see_all'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF696868),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (historyController.historyItems.isEmpty) {
                return boxShimmerPro(
                  width: Get.width,
                  height: 10,
                ); // or placeholder
              }
              final item = historyController.historyItems[0];
              return GestureDetector(
                onTap: () {
                  // handle tap
                },
                child: HistoryItemTile(
                  title: 'comunagua_water_bill'.tr,
                  date: item.paymentMonth,
                  status: item.status,
                ),
              );
            }),

            _buildTopUpButton(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentBill(ConsumerReadingModel data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF3FEFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'meter_number'.tr + ': ${data.meterNumber}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // const Icon(Icons.calendar_today, size: 20),
              Image.asset('assets/icons/calendar.png', height: 26, width: 24),
            ],
          ),
          Text(
            'exp_date'.tr + ': ${data.expiredAt.toString()}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Divider(color: Color(0xFF0B3A3D)),

          Column(
            children: [
              _buildBillRow('current_reading'.tr, '${data.currentReading} m³'),
              const SizedBox(height: 15),
              _buildBillRow(
                'last_month_reading'.tr,
                '${data.previousReading} m³',
              ),
              const SizedBox(height: 15),
              _buildBillRow('price_per_m3'.tr, '${data.perUnitCharge}'),
              const SizedBox(height: 15),
              _buildBillRow('minimum_fee'.tr, '${data.minimumFee} '),
              Divider(color: Color(0xFF0B3A3D)),
              const SizedBox(height: 10),
              _buildBillRow(
                'total_bill_of_this_month'.tr,
                '${data.totalAmount}',
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'status'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data.status.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          data.status == 'DUE'
                              ? const Color(0xFFFF9800)
                              : Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              data.status == 'DUE'
                  ? ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: Get.context!,
                        barrierDismissible: false,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment_rounded,
                                    color: Color(0xFF0B3A3D),
                                    size: 48,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'confirm_payment'.tr,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B3A3D),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'confirm_payment_message'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Color(0xFF0B3A3D),
                                            side: BorderSide(
                                              color: Color(0xFF0B3A3D),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                          ),
                                          child: Text('cancel'.tr),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            //TODO: Logic implementation
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF0B3A3D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                          ),
                                          child: Text(
                                            'proceed'.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B3A3D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      'pay_now'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xFF0B3A3D).withOpacity(0.6),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     minimumSize: const Size(double.infinity, 50),
              //   ),
              //   child: Text(
              //     'Thank You!',
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //       color: Color(0xFFFFFFFF),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildTopUpButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => RequestTopUpScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B3A3D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          'instant_top_up'.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
