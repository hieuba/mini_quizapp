// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionModel {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;
  QuestionModel({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}
