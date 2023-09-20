import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_quizapp/constants/colors.dart';

Widget startBtn(BuildContext context, {required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50.h,
      decoration: BoxDecoration(
          color: green5Color, borderRadius: BorderRadius.circular(15.r)),
      child: Center(
        child: Text(
          'Start quiz',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
            color: green1Color,
          ),
        ),
      ),
    ),
  );
}
