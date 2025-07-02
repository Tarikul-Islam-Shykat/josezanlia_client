import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_loader.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';

import '../../../generated/assets.dart';
import '../../Home_page_client/home_screens/controller/home_constroller.dart';
import '../controller/water_use_controller.dart';

class WaterUseView extends StatelessWidget {
  final controller = Get.put(WaterUseController());
  final waterController = Get.put(ConsumerReadingController());

  WaterUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Obx(() {
          if(waterController.isLoading.value){
            return loader();
          }
         /// final data = controller.selectReading;

          if (data == null) {
            return Center(child: Text("No data available"));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: 'Monthly Water Use', showBackButton: false),
                SizedBox(height: 10.h),
                // Month navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFE9FEFF),
                      child: IconButton(
                        onPressed: controller.previousMonth,
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 75.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9FEFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          controller.currentMonthLabel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFE9FEFF),
                      child: IconButton(
                        onPressed: controller.nextMonth,
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Image
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  Assets.imagesMeterImage,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      Assets.imagesMeterImage,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Details Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meter Number: ${data.meterNumber}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        detailRow(
                          "Current Reading",
                          "${data.currentReading} m³",
                        ),
                        detailRow(
                          "Last Month Reading",
                          "${data.lastMonthReading} m³",
                        ),
                        detailRow("Price Per m³", "${data.pricePerM3} MZN"),
                        detailRow("Minimum Fee", "${data.minimumFee} MZN"),
                        Divider(),
                        detailRow("Total Bill", "${data.totalBill} MZN"),
                        detailRow(
                          "Status",
                          data.status,
                          highlight: data.status == "DUE",
                        ),
                      ],
                    ),
                  ),
                ),
                // Add this after the Card widget
                SizedBox(height: 20),
                Text(
                  "Monthly Report",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 60, // adjust based on expected reading range
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 10,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final monthIndex = value.toInt();
                              if (monthIndex < controller.months.length) {
                                final label =
                                    controller.months[monthIndex].split(
                                      ' ',
                                    )[0]; // show only month
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    label,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      barGroups: controller.chartData,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget detailRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
