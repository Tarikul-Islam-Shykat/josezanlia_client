// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:josezanila_client/core/global_widegts/custom_app_bar.dart';
// import 'package:josezanila_client/core/global_widegts/custom_button.dart';
// import 'package:josezanila_client/core/global_widegts/custom_text_field.dart';
// import '../controller/forget_pasword_controller.dart';

// class ResetPassword extends StatelessWidget {
//   ResetPassword({super.key, required this.phone});

//   final String phone;
//   final ForgetPasswordController controller =
//       Get.find<ForgetPasswordController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background watermark (teardrop shape)
//             Center(
//               child: Opacity(
//                 opacity: 0.1,
//                 child: Icon(
//                   Icons.water_drop,
//                   size: 200,
//                   color: Colors.grey[400],
//                 ),
//               ),
//             ),
//             // Main content
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   CustomAppBar(title: 'Reset Password'),
//                   const SizedBox(height: 20),
//                   CustomTextField(
//                     textEditingController: controller.phoneNumberController,
//                     hitText: 'Phone Number',
//                   ),
//                   const Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 20.0),
//                     child: CustomButton(
//                       onPressed: () {
//                         // controller.sendPhoneNumber();
//                       },
//                       text: 'Continue',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
