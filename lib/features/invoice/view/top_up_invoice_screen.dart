// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/invoice/model/top_up_invoice_model.dart';
import 'package:prettyrini/features/nav_bar/view/nav_bar_view.dart';

class TopUpInvoiceScreen extends StatelessWidget {
  const TopUpInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final paymentDetails = PaymentDetails(
      number: "1123131133",
      tID: "CSUJHWS62635",
      time: "10: AM !2/2/25",
      amount: "600 MZN",
    );

    // final observations = Observations(
    //   items: [
    //     "The invoice service as a pro five of water consumption for residential purposes.",
    //     "In case of doubt, contact us for immediate attention.",
    //   ],
    // );

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
                          left: 16.0,
                          right: 16.0,
                          bottom: 20.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFC2DCDC).withValues(alpha: 0.50),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 16.h,
                              left: 16.w,
                              right: 16.w,
                            ),
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
                                // Payment Details Section
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
                                      "  Payment Details",
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
                                        "Your account number: ${paymentDetails.number}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Transaction ID: ${paymentDetails.tID}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Time: ${paymentDetails.time}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),

                                      Text(
                                        "Amount: ${paymentDetails.amount}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Divider(
                                        color: const Color(
                                          0xFF0B3A3D,
                                        ).withValues(alpha: 0.25),
                                      ),
                                    ],
                                  ),
                                ),

                                // Guidelines Section
                                Text(
                                  "Guidelines",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Upload clear proof of Payment",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "- A screenshot or photo of your M-Pesa/\n  E-Mola/Bank/Other receipt.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "• Your mobile number or reference used.\n• Amount Paid.\n• Date and time of the payment.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Only one file',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            " can be uploaded per request.\nOnce submitted, your request will be\nreviewed within 24 hours.\nYou will receive a notification once your\nbalance is updated.\nIf your request is missing details or unclear,\nit may be delayed or rejected.",
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(text: "For help, contact "),
                                      TextSpan(
                                        text: "ComunÁgua support",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " via whatsapp or phone.",
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                // Other Details Section
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

                            SizedBox(height: 12.h),
                            CustomButton(
                              onPressed: () {
                                Get.to(() => BottomNavbar());
                              },
                              text: 'Back to Top Up',
                              textColor: Color(0xFF0B3A3D),
                              backgroundColor: Color(0xFFFFFFFF),
                              borderSide: BorderSide(color: Color(0xFF0B3A3D)),
                              contentAlignment: MainAxisAlignment.center,
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
