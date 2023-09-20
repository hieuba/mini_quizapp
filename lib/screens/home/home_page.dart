import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_quizapp/components/start_button.dart';
import 'package:mini_quizapp/constants/colors.dart';
import 'package:mini_quizapp/data/subject_data.dart';
import 'package:mini_quizapp/models/subject_model.dart';
import 'package:mini_quizapp/screens/question/question.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            _buildAppBar(text: 'Main page'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildBody(context, titles: subjects),
                    ],
                  ),
                ),
              ),
            )
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

Widget _buildBody(BuildContext context, {required List<SubjectModel> titles}) {
  return Column(
    children: titles.map((subject) {
      return Column(
        children: [
          SizedBox(
            height: 40.h,
            child: Center(
              child: Text(
                subject.name,
                style: titleQuestion,
              ),
            ),
          ),
          startBtn(
            context,
            onTap: () {
              subject.name == 'math'
                  ? Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                      return Question(
                        subject: subject,
                      );
                    }))
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('chua cap nhat'),
                      ),
                    );
            },
          ),
        ],
      );
    }).toList(),
  );
}
