import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/views/profile_screen.dart';
import 'package:prettyrini/features/nav_bar/controller/nav_bar_controller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/style/global_text_style.dart';
import '../../Home_page_client/home_screens/view/home_view_screen.dart';
import '../../water_use/view/water_use_view.dart';


class NavBarView   extends StatelessWidget {
  final controller = Get.put(NavBarController());
  final List<Widget> _pages = [
    WaterBillHome(),
    WaterUseView(),
    WaterBillHome(),
    //Center(child: Text('Profile Page')),
    ProfileScreen(),
  ];

  NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: appGreenColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Obx(
              () => GNav(
            backgroundColor: appGreenColor,
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            selectedIndex: controller.selectedIndex.value,
            onTabChange: controller.changeTab,
            tabs: const [
              GButton(
                icon: Icons.house_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.system_update_alt_outlined,
                text: 'Meter Read',
              ),
              GButton(
                icon: Icons.analytics_outlined,
                text: 'Progress',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => _pages[controller.selectedIndex.value]),
    );
  }

}
