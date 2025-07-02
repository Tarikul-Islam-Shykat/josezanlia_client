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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFF0B3A3D).withValues(alpha: 0.10),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF0B3A3D),
                size: 16,
              ),
            ),
          ),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.notifications.length,
            itemBuilder: (context,index){
            final item = controller.notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(
                          0xFF0B3A3D,
                        ).withValues(alpha: 0.10),
                        child: Icon(
                          Icons.access_time,
                          color: Color(0xFF000000),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.body.toString(),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              DateFormat('dd MMM yyyy – hh:mm a').format(item.createdAt!),
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                            ),
                            // Row(
                            //   children: [
                            //     Text(item['date']!,
                            //       style: TextStyle(
                            //         color: Colors.grey[500],
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //     SizedBox(width: 10),
                            //     Text(
                            //       item['time']!,
                            //       style: TextStyle(
                            //         color: Colors.grey[500],
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Color(0xFF0B3A3D).withValues(alpha: 0.10)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
