import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import '../../../../../core/const/app_loader.dart';
import '../../../core/const/image_path.dart';
import '../../../core/widget/text_field_widget.dart';
import '../controller/profile_controller.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final EditProfileController controller =Get.put(EditProfileController());

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
                              : Center(
                            child: Image.asset(ImagePath.profile),
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
              CustomTextField(
                borderSide: BorderSide(
                  color:Colors.grey.shade500,
                ),
                fillColor: Color(0xFFFFFFFF),
                textEditingController:controller.dobTEC.value,
                onTap: ()=>controller.pickDate(context),
                suffixIcon: Icon(Icons.calendar_month,color: Colors.black,),
                readOnly: true,
                hitText: 'Birthday',
              ),
              SizedBox(height: 20.h,),
              Obx(() {
                return controller.isUploading.value?loader():CustomButton(
                  onPressed: () {
                    controller.uploadProfileImage();
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
