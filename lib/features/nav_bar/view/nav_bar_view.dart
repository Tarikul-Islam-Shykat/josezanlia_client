import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/nav_bar_images.dart';
import 'package:prettyrini/core/style/global_text_style.dart';
import 'package:prettyrini/features/Home_page_client/home_screens/view/home_view_screen.dart';
import 'package:prettyrini/features/history/view/history_view.dart';
import 'package:prettyrini/features/nav_bar/controller/nav_bar_controller.dart';
import 'package:prettyrini/features/water_use/view/water_use_view.dart';

import '../../profile/views/profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final BottomNavbarController controller = Get.put(BottomNavbarController());

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    _loadRoleAndInitPages();
  }

  Future<void> _loadRoleAndInitPages() async {
    setState(() {
      pages = [
        WaterBillHome(),
        WaterUseView(),
        HistoryScreen(),
        ProfileScreen(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      // backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() {
        return pages[controller.currentIndex.value];
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xFF0B3A3D),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  passiveImage: NavBarImages.actHome,
                  activeImage: NavBarImages.passHome,
                  index: 0,
                  label: 'Home',
                  imageHeight: 25,
                  imageWidth: 25,
                  iconColor: Colors.white,
                ),
                _buildNavItem(
                  passiveImage: NavBarImages.actChart,
                  activeImage: NavBarImages.passChart,
                  index: 1,
                  label: 'Water Use',
                  imageHeight: 25,
                  imageWidth: 25,
                  iconColor: Colors.white,
                ),
                _buildNavItem(
                  passiveImage: NavBarImages.actHistry,
                  activeImage: NavBarImages.passHistry,
                  index: 2,
                  label: 'History',
                  imageHeight: 25,
                  imageWidth: 25,
                  iconColor: Colors.white,
                ),
                _buildNavItem(
                  passiveImage: NavBarImages.actProfile,
                  activeImage: NavBarImages.passprofile,
                  index: 3,
                  label: 'Profile',
                  imageHeight: 25,
                  imageWidth: 25,
                  iconColor: Colors.white,
                ),
                // _buildNavItem(
                //   passiveImage: NavBarImages.actfeed,
                //   activeImage: NavBarImages.passfeed,
                //   index: 4,
                //   label: 'Feed',
                //   imageHeight: 25,
                //   imageWidth: 25,
                //   iconColor: Colors.white,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
    String? label,
    double? imageHeight,
    double? imageWidth,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFFFFFFF) : null,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isSelected ? activeImage : passiveImage,
                height: imageHeight ?? 25,
                width: imageWidth ?? 25,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 3.0),
              if (isSelected && label != null) ...[
                // const SizedBox(width: 5.0),
                Text(
                  label,
                  style: globalTextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
