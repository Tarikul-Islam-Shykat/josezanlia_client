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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'monthly_water_use'.tr,
                showBackButton: false,
              ),
              SizedBox(height: 10.h),

              Obx(() {
                final selectedData = waterController.selectedReading;
                if (waterController.isLoading.value) {
                  return loader();
                } else if (selectedData == null) {
                  return Center(child: Text('no_data_available'.tr));
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFE9FEFF),
                        child: IconButton(
                          onPressed: waterController.goToPreviousMonth,
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9FEFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          waterController.currentMonthLabel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xFFE9FEFF),
                        child: IconButton(
                          onPressed: waterController.goToNextMonth,
                          icon: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  );
                }
              }),
              SizedBox(height: 10),

              /// Meter Image with Dialog Preview
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
                                onTap: () => Get.back(),
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

              /// Details Card
              Obx(() {
                final selectedData = waterController.selectedReading;
                if (waterController.isLoading.value) {
                  return loader();
                } else if (selectedData == null) {
                  return Center(child: Text('no_data_available'.tr));
                } else {
                  return Card(
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
                            "${'meter_no'.tr}: ${selectedData.meterNumber ?? '-'}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          detailRow(
                            'current_reading'.tr,
                            "${selectedData.currentReading ?? '-'} m³",
                          ),
                          detailRow(
                            'previous_reading'.tr,
                            "${selectedData.previousReading ?? '-'} m³",
                          ),
                          detailRow(
                            'per_unit_charge'.tr,
                            "${selectedData.perUnitCharge ?? '-'} MZN",
                          ),
                          detailRow(
                            'minimum_bill'.tr,
                            "${selectedData.minimumFee ?? '-'} MZN",
                          ),
                          Divider(),
                          detailRow(
                            'total_amount'.tr,
                            "${selectedData.totalAmount ?? '-'} MZN",
                          ),
                          detailRow(
                            'status'.tr,
                            selectedData.status ?? '-',
                            highlight:
                                selectedData.status?.toLowerCase() == "due",
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),

              SizedBox(height: 20),
              Text(
                'monthwise_report'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),

              /// Chart Section
              FutureBuilder<List<BarChartGroupData>>(
                future: controller.chartData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 250,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: 250,
                      child: Center(child: Text('error_loading_chart_data'.tr)),
                    );
                  }

                  final barGroups = snapshot.data ?? [];

                  return SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY:
                            (barGroups.isNotEmpty
                                ? barGroups
                                    .map((g) => g.barRods.first.toY)
                                    .reduce((a, b) => a > b ? a : b)
                                : 0) +
                            200,
                        minY: 0,
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 500,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 60,
                              getTitlesWidget: (value, meta) {
                                final monthIndex = value.toInt();
                                final monthLabels = [
                                  'january'.tr,
                                  'february'.tr,
                                  'march'.tr,
                                  'april'.tr,
                                  'may'.tr,
                                  'june'.tr,
                                  'july'.tr,
                                  'august'.tr,
                                  'september'.tr,
                                  'october'.tr,
                                  'november'.tr,
                                  'december'.tr,
                                ];
                                if (monthIndex < monthLabels.length) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 5,
                                    child: Transform.rotate(
                                      angle: -0.785398,
                                      child: Text(
                                        monthLabels[monthIndex].substring(0, 3),
                                        style: TextStyle(fontSize: 10),
                                      ),
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
                        barGroups: barGroups,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
