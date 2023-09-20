// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:mini_quizapp/constants/colors.dart';
import 'package:mini_quizapp/screens/home/home_page.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.correctAnswer,
    required this.totalQuestions,
  }) : super(key: key);

  final int correctAnswer;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            _buildAppBar(text: 'Results'),
            // Text(
            //   '$correctAnswer / $totalQuestions',
            //   style: TextStyle(color: Colors.amber, fontSize: 40),
            // ),
            _buildBody(
              context,
              correctAnswer: correctAnswer,
              totalQuestions: totalQuestions,
            ),
            const Spacer(),
            _homeBtn(context),
          ],
        ),
      )),
    );
  }
}

Widget _buildAppBar({required String text}) {
  return Container(
    height: 50.h,
    decoration: BoxDecoration(color: green2Color),
    child: Center(
      child: Text(
        text,
        style: appBarStyle,
      ),
    ),
  );
}

Widget _buildBody(BuildContext context,
    {required int correctAnswer, totalQuestions}) {
  double percentage = (correctAnswer / totalQuestions) * 100;
  double wrongPercentage = 100 - percentage;
  return Column(
    children: [
      _circleProgress(
        correctAnswer: correctAnswer,
        totalQuestions: totalQuestions,
      ),
      _correctAnswer(text: '${percentage.toStringAsFixed(0)}% Correct answers'),
      _correctAnswer(
          text: '${wrongPercentage.toStringAsFixed(0)}% Wrong answers'),
    ],
  );
}

Widget _circleProgress({required int correctAnswer, totalQuestions}) {
  // Tính phần trăm đúng
  double percentage = (correctAnswer / totalQuestions) * 100;
  return Container(
    margin: const EdgeInsets.all(20),
    height: 300.h,
    width: double.infinity,
    child: FittedBox(
        child: CircularPercentIndicator(
      radius: 300,
      animation: true,
      animationDuration: 1200,
      lineWidth: 120.0,
      percent: percentage / 100,
      center: SizedBox(
        height: 250.h,
        child: Image.asset('assets/images/center_image.png'),
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: titleColor,
      progressColor: green4Color,
    )),
  );
}

Widget _correctAnswer({required String text}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    height: 50.h,
    decoration: BoxDecoration(
      color: green4Color,
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: titleColor,
        ),
      ),
    ),
  );
}

Widget _homeBtn(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 20.h),
      height: 80.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: green2Color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Image.asset('assets/icons/home_icon.png'),
        ),
      ),
    ),
  );
}
