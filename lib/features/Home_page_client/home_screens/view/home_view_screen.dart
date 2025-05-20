import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/features/Home_page_client/home_screens/controller/home_view_controller.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/view/pay_now_view_screen.dart';

import '../../../notifications/view/notifications_view.dart';

class WaterBillHome extends StatelessWidget {
  const WaterBillHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaterBillController controller = Get.put(WaterBillController());

    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeader(controller),
                Positioned(
                  top: 135, // The amount of overlap, adjust as needed
                  left: 20,
                  right: 20,
                  child: _buildCurrentBill(controller),
                ),
              ],
            ),
            // const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   // child: _buildCurrentBill(controller),
            // ),
            const SizedBox(height: 20),
            _buildRecentPayments(controller),
            const SizedBox(height: 40),
            _buildTopUpButton(),
            // // Add bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(WaterBillController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 400),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
              CircleAvatar(
                radius: 25,
                backgroundImage: const AssetImage(
                  'assets/images/header_image.png',
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Good Morning, ${controller.userName.value}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
                        const Text(
                          'Tap to see Balance',
                          style: TextStyle(fontSize: 12, color: Colors.black),
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
              Get.to(() => NotificationsView());
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // color: Colors.white.withValues(alpha: 0.2),
                    color: Color(0xFFE3E3E3).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF20800),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${controller.notificationCount.value}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBill(WaterBillController controller) {
    return Container(
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
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    'Meter Number: ${controller.meterNumber.value}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // const Icon(Icons.calendar_today, size: 20),
                Image.asset('assets/icons/calendar.png', height: 26, width: 24),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
              ),
            ),
            child: Row(
              children: [
                Obx(
                  () => Text(
                    'Exp Date: ${DateFormat('M/d/yy').format(controller.expiryDate.value)} (Penalty Change ${controller.penaltyCharge.value.toInt()} ${controller.currency.value})',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _buildBillRow(
                  'Current Reading:',
                  '${controller.currentReading} m³',
                  controller,
                ),
                const SizedBox(height: 15),
                _buildBillRow(
                  'Last Month Reading:',
                  '${controller.lastMonthReading} m³',
                  controller,
                ),
                const SizedBox(height: 15),
                _buildBillRow(
                  'Price Per m³:',
                  '${controller.pricePerUnit.toInt()} ${controller.currency}',
                  controller,
                ),
                const SizedBox(height: 15),
                _buildBillRow(
                  'Minimum Fee:',
                  '${controller.minimumFee.toInt()} ${controller.currency}',
                  controller,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                  ),
                  child: _buildBillRow(
                    'Total Bill of this Month:',
                    '${controller.totalBill.toInt()} ${controller.currency}',
                    controller,
                    isBold: true,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'The Status of Bill:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.billStatus.value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              controller.billStatus.value == 'DUE'
                                  ? const Color(0xFFFF9800)
                                  : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => PaymentScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3A3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
    String label,
    String value,
    WaterBillController controller, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 15,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 15,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPayments(WaterBillController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xF0000000),
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF696868),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(10),
                      // decoration: BoxDecoration(
                      //   color: Colors.blue.withOpacity(0.1),
                      //   shape: BoxShape.circle,
                      // ),
                      child: Image.asset(
                        'assets/icons/recentpayment_icon.png',
                        height: 40,
                        width: 40,
                      ),

                      // const Icon(
                      //   Icons.water_drop,
                      //   color: Colors.blue,
                      //   size: 24,
                      // ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.recentPayments[0]['provider'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => Text(
                            'Date: ${DateFormat('d MMMM yyyy').format(controller.recentPayments[0]['date'])}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    controller.recentPayments[0]['status'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B3A3D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          'Instant Top Up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
