import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/notifications_controller.dart';

class NotificationsView extends StatelessWidget {
  final controller = Get.put(NotificationController());

  NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFF0B3A3D).withValues(alpha: 0.15),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF0B3A3D),
                size: 18,
              ),
            ),
          ),
        ),
        title: Text(
          'notifications'.tr,
          style: TextStyle(
            color: Color(0xFF0B3A3D),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Card(
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.zero,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(
                              0xFF0B3A3D,
                            ).withValues(alpha: 0.15),
                            radius: 24,
                            child:
                                item.read == true
                                    ? Icon(
                                      Icons.notifications_active_rounded,
                                      color: Colors.redAccent,
                                      size: 24,
                                    )
                                    : Icon(
                                      Icons.notifications_active_rounded,
                                      color: Color(0xFF0B3A3D),
                                      size: 24,
                                    ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF0B3A3D),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  item.body.toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  DateFormat(
                                    'dd MMM yyyy – hh:mm a',
                                  ).format(item.createdAt!),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 4),
                      // Divider(
                      //   color: Color(0xFF0B3A3D).withValues(alpha: 0.1),
                      //   thickness: 1,
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
