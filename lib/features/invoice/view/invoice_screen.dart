// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/invoice/controller/invoice_controller.dart';
import 'package:prettyrini/features/nav_bar/view/nav_bar_view.dart';
import 'package:prettyrini/features/invoice/model/invoice_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key, required this.arguments});

  final Map<String, Object> arguments;
  final InvoiceController controller = Get.find<InvoiceController>();
  final UserProfileController userController =
      Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final args = arguments;

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
                      CustomAppBar(title: 'download_invoice'.tr),
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
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         // Placeholder for logo
                                //         Image.asset(
                                //           'assets/images/logo.png',
                                //           height: 55.h,
                                //           width: 55.w,
                                //           errorBuilder:
                                //               (context, error, stackTrace) =>
                                //                   const Icon(
                                //                     Icons.image,
                                //                     size: 55,
                                //                   ),
                                //         ),
                                //         SizedBox(width: 8.w),
                                //         Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               "ComunÁgua",
                                //               style: TextStyle(
                                //                 fontSize: 24.sp,
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Colors.black,
                                //               ),
                                //             ),
                                //             Text(
                                //               "Disponível todos os dias,\na toda a hora",
                                //               textAlign: TextAlign.start,
                                //               style: TextStyle(
                                //                 fontSize: 14.sp,
                                //                 color: Colors.black,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 16.h),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Text(
                                //                   "Savar, Dhaka, Bangladesh.",
                                //                   style: TextStyle(
                                //                     fontSize: 14.sp,
                                //                     color: Colors.black87,
                                //                   ),
                                //                 ),
                                //                 Text(
                                //                   "Fax: 12435678",
                                //                   style: TextStyle(
                                //                     fontSize: 14.sp,
                                //                     color: Colors.black87,
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //             SizedBox(width: 20.w),

                                //             Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.end,
                                //               children: [
                                //                 Text(
                                //                   "Date: 12/2/25",
                                //                   style: TextStyle(
                                //                     fontSize: 14.sp,
                                //                     color: Colors.black87,
                                //                   ),
                                //                 ),
                                //                 Text(
                                //                   "Invo.no: #6351s",
                                //                   style: TextStyle(
                                //                     fontSize: 14.sp,
                                //                     color: Colors.black87,
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           "NUIT: 732553209",
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.bold,
                                //             fontSize: 14.sp,
                                //             color: Colors.black87,
                                //           ),
                                //         ),
                                //         Text(
                                //           "support@comunagua.co.mz",
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.bold,
                                //             fontSize: 14.sp,
                                //             color: Colors.black87,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child:
                                      controller.policyDescription != null
                                          ? SizedBox(
                                            width: double.infinity,
                                            child: SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Html(
                                                      data:
                                                          controller
                                                              .policyDescription,
                                                      style: {
                                                        "body": Style(
                                                          fontSize: FontSize(
                                                            14.sp,
                                                          ),
                                                          color: Colors.black87,
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          : const SizedBox.shrink(),
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
                                      '  ${'personal_information'.tr}',
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
                                        '${'name'.tr}: ${userController.userProfile.value.consumer![0].firstName ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        '${'number'.tr}: ${userController.userProfile.value.phone ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        '${'location'.tr}: ${userController.userProfile.value.address ?? 'N/A'}',
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
                                      '  ${'invoice_details'.tr}',
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
                                            '${'meter_no'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            userController
                                                    .userProfile
                                                    .value
                                                    .consumer![0]
                                                    .meterNumber ??
                                                'N/A',
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
                                            '${'payment_month'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            args['paymentMonth'].toString(),
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
                                            '${'current_reading'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            args['currentReading'].toString(),
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
                                            '${'previous_reading'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            args['previousReading'].toString(),
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
                                            '${'consumption'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            args['consumption'].toString(),
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
                                            '${'per_unit_charge'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            "${(args['perUnitCharge'] as num?)?.toStringAsFixed(2) ?? '0.00'} MZN",
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
                                            '${'minimum_bill'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            "${(args['minimumBill'] as num?)?.toStringAsFixed(2) ?? '0.00'} MZN",
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
                                            '${'penalty_charge'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            "${(args['penaltyCharge'] as num?)?.toStringAsFixed(2) ?? '0.00'} MZN",
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
                                            '${'total_amount'.tr} :',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            args['totalAmount'].toString(),
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
                                            '${'payment_with'.tr}: ',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Text(
                                            "M-Pesa",
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
                                            '${'status'.tr}: ',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Text(
                                            args['status'].toString(),
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
                                      '  ${'guidelines'.tr}',
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
                                  child:
                                      controller.policyDescription != null
                                          ? SizedBox(
                                            width: double.infinity,
                                            child: SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Html(
                                                      data:
                                                          controller
                                                              .guidelineDescription,
                                                      style: {
                                                        "body": Style(
                                                          fontSize: FontSize(
                                                            14.sp,
                                                          ),
                                                          color: Colors.black87,
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          : const SizedBox.shrink(),
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
                                        'available_every_day'.tr,
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
                              onPressed: () async {
                                final pdf = pw.Document();
                                pdf.addPage(
                                  pw.MultiPage(
                                    pageFormat: PdfPageFormat.a4,
                                    build: (pw.Context context) {
                                      return [
                                        pw.Header(
                                          level: 0,
                                          child: pw.Text(
                                            'invoice'.tr,
                                            style: pw.TextStyle(
                                              fontSize: 24,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(height: 20),
                                        pw.Text(
                                          'personal_information'.tr,
                                          style: pw.TextStyle(
                                            fontSize: 18,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        pw.SizedBox(height: 10),
                                        pw.Text(
                                          '${'name'.tr}: ${userController.userProfile.value.consumer![0].firstName ?? 'N/A'}',
                                        ),
                                        pw.Text(
                                          '${'number'.tr}: ${userController.userProfile.value.phone ?? 'N/A'}',
                                        ),
                                        pw.Text(
                                          '${'location'.tr}: ${userController.userProfile.value.address ?? 'N/A'}',
                                        ),
                                        pw.SizedBox(height: 20),
                                        pw.Text(
                                          'invoice_details'.tr,
                                          style: pw.TextStyle(
                                            fontSize: 18,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        pw.SizedBox(height: 10),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'meter_no'.tr}:'),
                                            pw.Text(
                                              userController
                                                      .userProfile
                                                      .value
                                                      .consumer![0]
                                                      .meterNumber ??
                                                  'N/A',
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'payment_month'.tr}:'),
                                            pw.Text(
                                              args['paymentMonth'].toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'current_reading'.tr}:'),
                                            pw.Text(
                                              args['currentReading'].toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'previous_reading'.tr}:'),
                                            pw.Text(
                                              args['previousReading']
                                                  .toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'consumption'.tr}:'),
                                            pw.Text(
                                              args['consumption'].toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'per_unit_charge'.tr}:'),
                                            pw.Text(
                                              "${(args['perUnitCharge'] as num?)?.toStringAsFixed(2) ?? '0.00'} MZN",
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'minimum_bill'.tr}:'),
                                            pw.Text(
                                              "${(args['minimumBill'] as num?)?.toStringAsFixed(2) ?? '0.00'} MZN",
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text('${'penalty_charge'.tr}:'),
                                            pw.Text(
                                              "${(args['penaltyCharge'] as num?)?.toStringAsFixed(2) ?? '0.00'} MZN",
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Divider(),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              '${'total_amount'.tr}:',
                                            ),
                                            pw.Text(
                                              args['totalAmount'].toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          children: [
                                            pw.Text('Payment With: '),
                                            pw.Text(
                                              'M-Pesa',
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Row(
                                          children: [
                                            pw.Text('Status: '),
                                            pw.Text(
                                              args['status'].toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ];
                                    },
                                  ),
                                );
                                final output = Directory(
                                  '/storage/emulated/0/Download',
                                );
                                final file = File(
                                  "${output.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf",
                                );
                                await file.writeAsBytes(await pdf.save());
                                Fluttertoast.showToast(
                                  msg: "PDF saved to Downloads: ${file.path}",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                );
                              },
                              text: 'Download',
                              backgroundColor: Color(0xFF0B3A3D),
                              contentAlignment: MainAxisAlignment.center,
                            ),
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
