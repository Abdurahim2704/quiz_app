import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ibrat_informatika/bloc/local_saving/test_result_bloc.dart';
import 'package:ibrat_informatika/core/constants/colors.dart';
import 'package:ibrat_informatika/core/routes/app_routes.dart';
import 'package:ibrat_informatika/core/routes/route_names.dart';

import '../overview_page/components/test_result_maker.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  void saveData(List<bool> userAnswers, BuildContext context,
      List<String> questions, List<String> answers, String title) {
    final accuracy =
        (userAnswers.where((e) => e).length) / (userAnswers.length);
    context.read<TestResultBloc>().add(SaveResultEvent(
        questions: questions,
        userAnswers: userAnswers,
        accuracy: accuracy,
        title: title,
        answers: answers));
  }

  @override
  Widget build(BuildContext context) {
    final data = AppRoutes.route.routerDelegate.currentConfiguration.extra
        as Map<String, Object?>;
    final userAnswers = data["user_answers"] as List<bool>;
    final questions = data["questions"] as List<String>;
    final answers = data["answers"] as List<String>;
    final image = data["images"] as List<String?>;
    final title = data["title"] as String;
    saveData(userAnswers, context, questions, answers, title);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Test results"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Savol Natijalari",
              style: TextStyle(fontSize: 30.sp),
            ),
            SizedBox(
              height: 20.sp,
            ),
            TestResultMaker(
                value:
                    "${userAnswers.where((element) => element).length}/${answers.length}",
                attribute: "To'g'ri javoblar soni : "),
            SizedBox(
              height: 5.sp,
            ),
            TestResultMaker(
                attribute: "Darsni o'zlashtirish darajasi: ",
                value:
                    "${((userAnswers.where((element) => element).length / answers.length) * 100)}%"),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              "Noto'g'ri javob berilgan savollar",
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(
              height: 17.sp,
            ),
            SizedBox(
              height: 400.sp,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 5.sp,
                  );
                },
                itemBuilder: (context, index) {
                  if (userAnswers[index] == true) {
                    return const SizedBox.shrink();
                  }
                  final question = questions[index];
                  final answer = answers[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question,
                            style: TextStyle(color: Colors.black),
                          ),
                          if (image[index] != null) Image.asset(image[index]!)
                        ],
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          Expanded(
                            child: Text(
                              answer,
                              softWrap: true,
                              style: const TextStyle(color: Colors.green),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: userAnswers.length,
              ),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.1)),
                onPressed: () {
                  context.goNamed(RouteNames.home);
                },
                child: const Text(
                  "Testni tugatish",
                  style: TextStyle(color: Colors.black),
                )),
            SizedBox(
              height: 40.sp,
            )
          ],
        ),
      ),
    );
  }
}
