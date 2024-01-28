import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ibrat_informatika/bloc/local_saving/test_result_bloc.dart';
import 'package:ibrat_informatika/presentation/pages/home_page/components/course_list_view.dart';
import 'package:ibrat_informatika/presentation/pages/home_page/components/progress_indicator.dart';
import 'package:ibrat_informatika/presentation/pages/profile_page/profile_page.dart';

import '../../../core/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Xush Kelibsiz",
          style: TextStyle(fontSize: 19.sp),
        ),
      ),
      body: Stack(
        children: [
          index == 0 ? const CourseListView() : const ProfilePage(),
          if (context.watch<TestResultBloc>().state is TestResultLoading)
            const CustomProgressIndicator()
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 17.h),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          backgroundColor: Colors.white,
          tabMargin: EdgeInsets.symmetric(vertical: 10.sp),
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          tabBorder: Border.all(color: Colors.grey, width: 1),
          gap: 8,
          color: Colors.black,
          activeColor: Colors.black,
          iconSize: 24,
          tabBackgroundColor: AppColors.appBarColor,
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
          onTabChange: (value) {
            setState(() {
              index = value;
            });
          },
          tabs: [
            const GButton(
              backgroundColor: AppColors.appBarColor,
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              backgroundColor: Colors.blue.withOpacity(0.6),
              icon: Icons.person,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
