import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Privacy Policy'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "At Firstly, your privacy is our priority. Here's a summary of how we handle your data:",
                      style: TextStyle(fontSize: 14.sp, height: 1.6),
                    ),
                    SizedBox(height: 5.h),

                    /// 1. Information We Collect
                    _buildSectionTitle("1. Information We Collect"),
                    _buildBullet(
                      "Profile details: Name, email, photos, and preferences.",
                    ),
                    _buildBullet(
                      "Location: Use your nearby location for received product fastly.",
                    ),
                    _buildBullet(
                      "Device data: For app performance and security.",
                    ),

                    SizedBox(height: 5.h),

                    /// 2. How We Use Your Data
                    _buildSectionTitle("2. How We Use Your Data"),
                    _buildBullet("To create purchase your order properly."),
                    _buildBullet(
                      "To improve app features and user experience.",
                    ),
                    _buildBullet(
                      "For communication, notifications, and promotions (you can opt-out anytime).",
                    ),

                    SizedBox(height: 5.h),

                    /// 3. Data Sharing
                    _buildSectionTitle("3. Data Sharing"),
                    _buildBullet("We never sell your data."),
                    _buildBullet(
                      "Limited sharing with seller for app functionality (e.g., payment processing).",
                    ),

                    SizedBox(height: 5.h),

                    /// 4. Your Control
                    _buildSectionTitle("4. Your Control"),
                    _buildBullet("Update or delete your profile anytime."),
                    _buildBullet(
                      "Control delete post and other functionality.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color(0xFF2F2F2F),
        fontSize: 15.sp,
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h, left: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF2F2F2F)),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: Color(0xFF2F2F2F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
