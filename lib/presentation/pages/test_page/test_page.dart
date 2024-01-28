import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ibrat_informatika/core/constants/colors.dart';
import 'package:ibrat_informatika/core/routes/route_names.dart';
import 'package:ibrat_informatika/data/models/models.dart';

import 'components/showBottom.dart';

class TestPage extends StatefulWidget {
  final Lesson lesson;
  const TestPage({super.key, required this.lesson});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int questionIndex = 0;
  int? answer;
  List<bool> answers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.lesson.title,
          style: TextStyle(
              color: Colors.white,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp),
        ),
        leading: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          //#quiz cart
          SizedBox(
            height: 588.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 33.w),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Container(
                    height: 580.h,
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.lesson.questions[questionIndex].question,
                            style:
                                TextStyle(color: Colors.black, fontSize: 19.sp),
                          ),
                          if (widget.lesson.questions[questionIndex].image !=
                              null)
                            Image.asset(
                                widget.lesson.questions[questionIndex].image!),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            itemBuilder: (context, index) {
                              final variant = widget.lesson
                                  .questions[questionIndex].variants[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.sp),
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Radio(
                                      value: index,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>((states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors.blue;
                                        }
                                        return Colors.black26;
                                      }),
                                      groupValue: answer,
                                      onChanged: (value) {
                                        setState(() {
                                          answer = value;
                                        });
                                      },
                                    ),
                                    title: Text(
                                      variant,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.sp))),
                                    tileColor: Colors.white,
                                  ),
                                ),
                              );
                            },
                            itemCount: widget.lesson.questions[questionIndex]
                                .variants.length,
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 20.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.sp))),
                minimumSize: Size(
                  MediaQuery.of(context).size.width,
                  50.sp,
                ),
              ),
              onPressed: () {
                if (answer == null) {
                  return;
                }
                answers.add(
                    widget.lesson.questions[questionIndex].answer == answer);
                showBottom(context,
                        widget.lesson.questions[questionIndex].answer == answer)
                    .whenComplete(() {
                  if (questionIndex + 1 == widget.lesson.questions.length) {
                    context.goNamed(
                      RouteNames.resultPage,
                      extra: {
                        "title": widget.lesson.title,
                        "images": widget.lesson.questions
                            .map((e) => e.image)
                            .toList(),
                        "questions": widget.lesson.questions
                            .map((e) => e.question)
                            .toList(),
                        "answers": widget.lesson.questions
                            .map((e) => e.variants[e.answer])
                            .toList(),
                        "user_answers": answers.toList(),
                      },
                    );
                    return;
                  }
                  setState(() {
                    questionIndex++;
                    answer = null;
                  });
                });
              },
              child: const Text("Tekshirish"),
            ),
          ),
        ],
      ),
      bottomSheet: const SizedBox.shrink(),
    );
  }
}
