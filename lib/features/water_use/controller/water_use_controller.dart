import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



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

  /// Chart bar values
  List<BarChartGroupData> get chartData {
    return List.generate(months.length, (index) {
      final data = FakeMeterService.getMeterData(months[index]);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data?.currentReading ?? 0,
            width: 14,
            color: data?.status == 'DUE' ? const Color(0xFFE57373) : const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }
}


