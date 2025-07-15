import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/repository/network_caller/endpoints.dart';

class MeterData {
  final String meterNumber;
  final double currentReading;
  final double lastMonthReading;
  final double pricePerM3;
  final double minimumFee;
  final double totalBill;
  final String status;

  MeterData({
    required this.meterNumber,
    required this.currentReading,
    required this.lastMonthReading,
    required this.pricePerM3,
    required this.minimumFee,
    required this.totalBill,
    required this.status,
  });
}

class FakeMeterService {
  static final Map<String, MeterData> _meterDatabase = {
    'February 2025': MeterData(
      meterNumber: 'A73353',
      currentReading: 44.22,
      lastMonthReading: 50.22,
      pricePerM3: 70,
      minimumFee: 300,
      totalBill: 200,
      status: 'DUE',
    ),
    'March 2025': MeterData(
      meterNumber: 'A73353',
      currentReading: 38.50,
      lastMonthReading: 44.22,
      pricePerM3: 70,
      minimumFee: 300,
      totalBill: 180,
      status: 'PAID',
    ),
    'April 2025': MeterData(
      meterNumber: 'A73353',
      currentReading: 44.22,
      lastMonthReading: 50.22,
      pricePerM3: 70,
      minimumFee: 300,
      totalBill: 200,
      status: 'DUE',
    ),
    'May 2025': MeterData(
      meterNumber: 'A73353',
      currentReading: 38.50,
      lastMonthReading: 44.22,
      pricePerM3: 70,
      minimumFee: 300,
      totalBill: 180,
      status: 'PAID',
    ),
    'June 2025': MeterData(
      meterNumber: 'A73353',
      currentReading: 38.50,
      lastMonthReading: 44.22,
      pricePerM3: 70,
      minimumFee: 300,
      totalBill: 180,
      status: 'PAID',
    ),
    'July 2025': MeterData(
      meterNumber: 'A73353',
      currentReading: 38.50,
      lastMonthReading: 44.22,
      pricePerM3: 70,
      minimumFee: 300,
      totalBill: 180,
      status: 'PAID',
    ),
    // Add more months here
  };

  static MeterData? getMeterData(String monthYear) {
    return _meterDatabase[monthYear];
  }

  static List<String> get availableMonths => _meterDatabase.keys.toList();
}

class WaterUseController extends GetxController {
  final RxInt currentMonthIndex = 0.obs;
  final Rx<MeterData?> meterData = Rx<MeterData?>(null);

  List<String> months = FakeMeterService.availableMonths;

  final UserProfileController userController = Get.put(UserProfileController());

  @override
  void onInit() {
    currentMonthIndex.value = months.length - 1;
    loadMeterData();
    super.onInit();
  }

  void loadMeterData() {
    final month = months[currentMonthIndex.value];
    meterData.value = FakeMeterService.getMeterData(month);
  }

  void nextMonth() {
    if (currentMonthIndex.value < months.length - 1) {
      currentMonthIndex.value++;
      loadMeterData();
    }
  }

  void previousMonth() {
    if (currentMonthIndex.value > 0) {
      currentMonthIndex.value--;
      loadMeterData();
    }
  }

  String get currentMonthLabel => months[currentMonthIndex.value];

  Future<Map<String, dynamic>> getChartData() async {
    final networkconfig = NetworkConfig();
    final year = DateTime.now().year.toString();
    final id = userController.userProfile.value.consumer![0].id!;
    final url = '${Urls.getMonthlyReport}/$id/$year';

    final response = await networkconfig.ApiRequestHandler(
      RequestMethod.GET,
      url,
      '',
      is_auth: true,
    );
    return response ?? {'error': 'Failed to fetch data'};
  }

  Future<List<BarChartGroupData>> get chartData async {
    final Map<String, dynamic> response = await getChartData();
    List<dynamic> yearlyConsumption = [];
    if (response['success'] == true && response['data'] != null) {
      yearlyConsumption = response['data']['yearlyConsumption'] ?? [];
    }
    return List.generate(yearlyConsumption.length, (index) {
      double reading = 0;
      if (index < yearlyConsumption.length) {
        final monthData = yearlyConsumption[index];
        reading = (monthData['totalReadings'] as num).toDouble();
      }
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: reading,
            width: 20,
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }
}
