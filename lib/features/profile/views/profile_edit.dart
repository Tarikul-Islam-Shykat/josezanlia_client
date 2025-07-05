import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';
import '../../../../../core/const/app_loader.dart';
import '../../../core/const/image_path.dart';
import '../../../core/global_widegts/custom_cached_image.dart';
import '../controller/profile_controller.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final EditProfileController controller = Get.put(EditProfileController());
  final profileController = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFCFE4DD),
            Color(0xFFF1F3F3),
          ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              CustomAppBar(title: 'Edit Profile'),

              SizedBox(height: 20.h,),
              // GestureDetector(
              //   onTap: () async {
              //     final ImagePicker picker = ImagePicker();
              //     final XFile? image = await picker.pickImage(
              //       source: ImageSource.gallery,
              //     );
              //     if (image != null) {
              //       controller.updateProfileImage(File(image.path));
              //     }
              //   },
              //   child: Stack(
              //     clipBehavior: Clip.none,
              //     children: [
              //       Obx(() {
              //         if (controller.profileImage.value != null) {
              //           return CircleAvatar(
              //             radius: 50.r, // Adjust radius as needed
              //             backgroundImage:
              //             controller.profileImage.value != null
              //                 ? FileImage(controller.profileImage.value!)
              //                 : Image.asset(ImagePath.profile)
              //             as ImageProvider,
              //             child:
              //             controller.profileImage.value == null
              //                 ? null // No child if image is from asset
              //                 : ClipOval(
              //               // Clip if image is from file to ensure circular shape
              //               child: Image.file(
              //                 controller.profileImage.value!,
              //                 height: 100.h,
              //                 width: 100.w,
              //                 fit: BoxFit.cover,
              //                 errorBuilder:
              //                     (
              //                     context,
              //                     error,
              //                     stackTrace,
              //                     ) => Image.asset(ImagePath.profile),
              //               ),
              //             ),
              //           );
              //         } else {
              //           // return CircleAvatar(
              //           //   radius: 50.r, // Adjust radius as needed
              //           //   backgroundColor: Colors.grey.shade200,
              //           //   child: Image.network(
              //           //     controller.userImage.value,
              //           //     height: 100.h,
              //           //     width: 100.w,
              //           //   ),
              //           // );
              //
              //           return CustomCachedImage(
              //             imageUrl: controller.userImage.value,
              //             type: CustomImageType.avatar,
              //             radius: 50.r,
              //           );
              //         }
              //       }),
              //       Positioned(
              //         bottom: 20.h,
              //         right: -10,
              //         child: Image.asset(ImagePath.profile)
              //       ),
              //     ],
              //   ),
              // ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Obx((){
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:controller.profileImage.value != null
                              ? Image.file(
                            controller.profileImage.value!,
                            fit: BoxFit.cover,
                            width: 105,
                            height: 105,
                          )
                              : CustomCachedImage(
                            imageUrl:
                            profileController.userProfile.value.profileImage.toString(),
                            type: CustomImageType.avatar,
                            radius: 50,
                          ),
                        ),
                      );
                    }
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: InkWell(
                        onTap: (){
                          _showImagePickerOptions(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(100),
                              color: Colors.grey.shade200
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              CustomTextField(
                borderSide: BorderSide(
                  color:Colors.grey.shade500,
                ),
                fillColor: Color(0xFFFFFFFF),
                textEditingController:controller.nameTEC.value,
                hitText: 'Name',
              ),
              SizedBox(height: 10.h,),
              CustomTextField(
                borderSide: BorderSide(
                  color:Colors.grey.shade500,
                ),
                fillColor: Color(0xFFFFFFFF),
                textEditingController:controller.phoneTEC.value,
                keyboardType: TextInputType.phone,
                hitText: 'Phone',
              ),
              SizedBox(height: 10.h,),
              // CustomTextField(
              //   borderSide: BorderSide(
              //     color:Colors.grey.shade500,
              //   ),
              //   fillColor: Color(0xFFFFFFFF),
              //   textEditingController:controller.dobTEC.value,
              //   onTap: ()=>controller.pickDate(context),
              //   suffixIcon: Icon(Icons.calendar_month,color: Colors.black,),
              //   readOnly: true,
              //   hitText: 'Birthday',
              // ),
              SizedBox(height: 20.h,),
              Obx(() {
                return controller.isUpdateProfileLoading.value?loader():CustomButton(
                  onPressed: () {
                    controller.updateProfile();
                  },
                  text: 'Update',
                  // borderColor: Color(0xFF1F3892),
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF0B3A3D),
                  width: Get.width,
                  borderRadius: 10,
                );
              }
              ),

            ],
          ),
        ),
      ),
    );
  }


  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Select Profile Picture',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color:Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(
                  context,
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    controller.pickProfileImageFormCamera();
                  },
                ),
                _buildImageOption(
                  context,
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    controller.pickProfileImage();
                  },
                ),
              ],
            ),
            if (controller.profileImage.value != null) ...[
              SizedBox(height: 20.h),
              _buildImageOption(
                context,
                icon: Icons.delete,
                label: 'Remove',
                color: Colors.red,
                onTap: () {
                  Get.back();
                  controller.clearImage();
                },
              ),
            ],
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
        Color? color,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: (color ?? AppColors.primaryColor).withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30.sp,
              color: color ?? AppColors.primaryColor,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: color ??Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
