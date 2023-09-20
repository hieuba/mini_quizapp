import 'package:mini_quizapp/data/math_question.dart';
import 'package:mini_quizapp/models/subject_model.dart';

List<SubjectModel> subjects = [
  SubjectModel(
    name: 'math',
    questions: mathQuestions,
  ),
  SubjectModel(
    name: 'sub1',
    questions: [],
  ),
  SubjectModel(
    name: 'sub2',
    questions: [],
  ),
  SubjectModel(
    name: 'sub3',
    questions: [],
  ),
  SubjectModel(
    name: 'sub4',
    questions: [],
  ),
  // Thêm các môn học khác và danh sách câu hỏi tương ứng
];
