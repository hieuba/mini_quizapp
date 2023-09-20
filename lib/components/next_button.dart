import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_quizapp/constants/colors.dart';

Widget nextBtn(BuildContext context,
    {required String text, required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: green2Color,
        borderRadius: BorderRadius.circular(25.h),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: 25.sp,
            color: titleColor,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700),
      )),
    ),
  );
}
