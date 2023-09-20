// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mini_quizapp/components/last_button.dart';
import 'package:mini_quizapp/components/next_button.dart';
import 'package:mini_quizapp/constants/colors.dart';
import 'package:mini_quizapp/constants/generate_map_answer.dart';
import 'package:mini_quizapp/models/question_model.dart';
import 'package:mini_quizapp/models/subject_model.dart';
import 'package:mini_quizapp/screens/result/result.dart';

class Question extends StatefulWidget {
  const Question({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final SubjectModel subject;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int currentQuestionIndex = 0; // Dùng để theo dõi câu hỏi hiện tại

  // tạo obj câu trả lời
  Map<int, dynamic> objAnswers = generateMap(0);

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.subject.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void goToLastQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  // choose question index
  void _choseQuestionIndex(currentQuestionIndex, answerIndex) {
    setState(() {
      objAnswers = {...objAnswers, currentQuestionIndex: answerIndex};
    });
  }

  // total correct answers
  int calculateCorrectAnswers() {
    int correctAnsewers = 0;

    for (var i = 0; i < widget.subject.questions.length; i++) {
      if (objAnswers.containsKey(i) &&
          objAnswers[i] == widget.subject.questions[i].correctAnswerIndex) {
        correctAnsewers++;
      }
    }
    return correctAnsewers;
  }

  void _navigateToResultScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Result(
          correctAnswer: calculateCorrectAnswers(),
          totalQuestions: widget.subject.questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var totalQuestions = widget.subject.questions.length;

    QuestionModel currentQuestion =
        widget.subject.questions[currentQuestionIndex];

    String titleText = "${currentQuestionIndex + 1}/$totalQuestions";
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              _buildAppBar(text: widget.subject.name, totalText: titleText),
              _textQuesiton(quesionText: currentQuestion.questionText),
              _answerQuestion(
                answers: currentQuestion.answers,
                currentQuestionIndex: currentQuestionIndex,
                onAnswerSelected: _choseQuestionIndex,
                objAnswers: objAnswers,
              ),
              const Spacer(),
              // next and previos button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: lastBtn(
                    context,
                    text: 'Last',
                    onTap: () {
                      goToLastQuestion();
                    },
                  )),
                  const SizedBox(width: 30),
                  Expanded(
                      child: nextBtn(
                    context,
                    text: 'Next',
                    onTap: () {
                      if (currentQuestionIndex <
                          widget.subject.questions.length - 1) {
                        goToNextQuestion();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Notification'),
                              content: const Text(
                                  'Are you sure you have completed the question?'),
                              actions: [
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.cancel),
                                  label: Text(
                                    'Cancle',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    _navigateToResultScreen();
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  label: Text(
                                    'Ok',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildAppBar({required String text, required String totalText}) {
  return Container(
    height: 50.h,
    decoration: BoxDecoration(
        color: green2Color, borderRadius: BorderRadius.circular(25.r)),
    child: Center(
      child: Text(
        '$text $totalText',
        style: appBarStyle,
      ),
    ),
  );
}

Widget _textQuesiton({required String quesionText}) {
  return Container(
    margin: const EdgeInsets.only(top: 20, bottom: 20),
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      color: green4Color,
    ),
    child: Center(
      child: Text(
        quesionText,
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat',
          color: green1Color,
        ),
      ),
    ),
  );
}

Widget _answerQuestion({
  required List<String> answers,
  required int
      currentQuestionIndex, // Thêm tham số này để truyền index của câu hỏi hiện tại
  required Function(int, int)
      onAnswerSelected, // Thêm tham số này để gọi _choseQuestionIndex
  required Map<int, dynamic> objAnswers,
}) {
  return Column(
    children: List.generate(answers.length, (index) {
      final int answerIndex = index;
      final String answer = answers[index];

      bool isActiveAnswer = objAnswers[currentQuestionIndex] == index;

      return InkWell(
        onTap: () {
          onAnswerSelected(currentQuestionIndex, answerIndex);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          height: 40.h,
          decoration: BoxDecoration(
            color: isActiveAnswer ? Colors.amber : green5Color,
            borderRadius: BorderRadius.circular(
              15.r,
            ),
          ),
          child: Center(
            child: Text(
              answer,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: titleColor),
            ),
          ),
        ),
      );
    }).toList(),
  );
}
