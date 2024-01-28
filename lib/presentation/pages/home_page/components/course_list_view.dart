import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../chapters_page/chapters_page.dart';
import 'custom_listile.dart';

class CourseListView extends StatelessWidget {
  const CourseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      itemBuilder: (context, index) {
        final course = context.read<HomeBloc>().state.courses[index];
        return CustomListile(
            title: course.title,
            subtitle:
                "${course.chapters.length} ta bob ${course.chapters.fold<int>(0, (previousValue, element) => previousValue + element.lessons.length)} ta dars",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChaptersPage(course: course),
              ));
            },
            trailingImage: course.headerImage);
      },
      itemCount: context.read<HomeBloc>().state.courses.length,
    );
  }
}
