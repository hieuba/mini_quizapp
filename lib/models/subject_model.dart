// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mini_quizapp/models/question_model.dart';

class SubjectModel {
  final String name;
  final List<QuestionModel> questions; // Danh sách câu hỏi tương ứng với môn

  SubjectModel({
    required this.name,
    required this.questions,
  });
}
