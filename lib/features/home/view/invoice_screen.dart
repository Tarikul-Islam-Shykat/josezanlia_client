// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/home/model/model.dart';
import 'package:prettyrini/features/nav_bar/view/nav_bar_view.dart';
import 'package:prettyrini/features/home/model/invoice_model.dart';
class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final personalInfo = PersonalInformation(
      name: "Adam Click",
      number: "8237339248",
      location: "Saver, Dhaka",
    );

    final otherDetails = OtherDetails(
      meterNumber: "44.22 m³",
      currentReading: "44.22 m³",
      lastMonthReading: "44.22 m³",
      consumption: "30 m³",
      pricePerM3: "70 MZN",
      minimumFare: "350 MZN",
      penaltyFare: "00 MZN",
      paymentStatus: "Paid",
      paymentMethod: "M-Pesa",
    );

    final observations = Observations(
      items: [
        "The invoice service as a pro five of water consumption for residential purposes.",
        "In case of doubt, contact us for immediate attention.",
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/drop.png',
              width: 150.w,
              height: 150.h,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const CustomAppBar(title: 'Invoice'),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 16.h,
                          left: 16.w,
                          right: 16.w,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFC2DCDC).withValues(alpha: 0.50),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header Section
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Placeholder for logo
                                        Image.asset(
                                          'assets/images/logo.png',
                                          height: 55.h,
                                          width: 55.w,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                                    Icons.image,
                                                    size: 55,
                                                  ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "ComunÁgua",
                                              style: TextStyle(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Disponível todos os dias,\na toda a hora",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Savar, Dhaka, Bangladesh.",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Text(
                                                  "Fax: 12435678",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 20.w),

                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Date: 12/2/25",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Text(
                                                  "Invo.no: #6351s",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "NUIT: 732553209",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "support@comunagua.co.mz",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18.h),
                                // Personal Information Section
                                Container(
                                  height: 30.h,
                                  width: screenWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF0B3A3D,
                                    ).withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "  Personal Information",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${personalInfo.name}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "Number: ${personalInfo.number}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "Location: ${personalInfo.location}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                // Other Details Section
                                Container(
                                  height: 30.h,
                                  width: screenWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF0B3A3D,
                                    ).withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "  Other Details",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Meter Number :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.meterNumber,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Current Reading :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.currentReading,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Last Month Reading :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.lastMonthReading,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Consumption :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.consumption,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Price Per m³ :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.pricePerM3,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Minimum Fare :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.minimumFare,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Penalty Fare :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.penaltyFare,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: const Color(
                                          0xFF0B3A3D,
                                        ).withValues(alpha: 0.50),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Bill of this Month :",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            otherDetails.totalBill,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Payment With:",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Text(
                                            otherDetails.paymentMethod,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Status:",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Text(
                                            otherDetails.paymentStatus,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                // Observations Section
                                Container(
                                  height: 30.h,
                                  width: screenWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF0B3A3D,
                                    ).withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      "  Observations",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        observations.items.map((item) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 12.h,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "• ",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                  child: Column(
                                    children: [
                                      Divider(
                                        color: const Color(
                                          0xFF0B3A3D,
                                        ).withValues(alpha: 0.25),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "Available every day, at all hours",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Footer Buttons
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          children: [
                            CustomButton(
                              prefixIconPath: 'assets/images/download.png',
                              onPressed: () {},
                              text: 'Download',
                              backgroundColor: Color(0xFF0B3A3D),
                              contentAlignment: MainAxisAlignment.center,
                            ),
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: const Color(0xFF0B3A3D),
                            //     minimumSize: const Size(double.infinity, 50),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8.r),
                            //     ),
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       const Icon(Icons.download, color: Colors.white),
                            //       SizedBox(width: 8.w),
                            //       Text(
                            //         "Download",
                            //         style: TextStyle(
                            //           fontSize: 16.sp,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 12.h),
                            OutlinedButton(
                              onPressed: () {
                                Get.to(() => BottomNavbar());
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF0B3A3D),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                "Back to Home",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF0B3A3D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h), // Extra padding at the bottom
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
