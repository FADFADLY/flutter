import 'package:bloc/bloc.dart';
import 'package:graduationproject/config/cache/cache_helper.dart';
import 'package:graduationproject/features/test/domain/entities/question/question.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/question_response_model/question_modal.dart';
import '../../../../domain/repo/repo.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({required this.testRepo}) : super(QuestionsInitial());
  final TestRepository testRepo;

  List<String> listOfQuestions = [];
  List<List<String>> listOfAnswers = [];
  Map<int, String> selectedAnswers = {};
  String? testName;
  String? description;

  List<List<String>> groupedQuestions = [];
  List<List<List<String>>> groupedAnswers = [];

  List<QuestionEntity> questionsList = [];
  Map<String, int> answers = {};

  int currentPage = 0;
  int get totalPages => (listOfQuestions.length / 3).ceil();

  void reset() {
    listOfQuestions.clear();
    listOfAnswers.clear();
    description = null;
    selectedAnswers.clear();
    groupedQuestions.clear();
    groupedAnswers.clear();
    testName = null;
    currentPage = 0;
    questionsList.clear();
    answers.clear();
    emit(QuestionsInitial());
  }

  Future<void> getAllQuestions() async {
    reset();

    final testId = CacheHelper.getInt(key: 'selected_test_id');
    testName = CacheHelper.getString(key: 'selected_test_name');

    if (testId == null || testName == null) {
      emit(QuestionsError(message: "لم يتم اختيار اختبار"));
      return;
    }

    emit(QuestionsLoading());
    final questions = await testRepo.getAllQuestions(testId);
    questions.fold(
          (failure) {
        emit(QuestionsError(message: failure.message));
        print(failure.message);
      },
          (success) {
        questionsList = success.questions;
        emit(QuestionsSuccess(questions: success.questions));
        listOfQuestions = success.questions.map((item) => item.question).toList();
        description = success.description;
        listOfAnswers = success.questions.map((item) {
          return item.answers.map((answer) => answer.answer).toList();
        }).toList();

        for (int i = 0; i < listOfQuestions.length; i += 3) {
          final end = (i + 3) < listOfQuestions.length ? (i + 3) : listOfQuestions.length;
          groupedQuestions.add(listOfQuestions.sublist(i, end));
          groupedAnswers.add(listOfAnswers.sublist(i, end));
        }

        print(groupedAnswers);
        emit(UpdatePageState());
      },
    );
  }

  void selectAnswer(int questionIndex, String answer) {
    selectedAnswers[questionIndex] = answer;

    // جلب QID و AID من questionsList
    final qid = questionsList[questionIndex].id.toString();
    final aid = questionsList[questionIndex].answers
        .firstWhere((a) => a.answer == answer)
        .id;

    print('Before update - Answers: $answers'); // Log قبل التحديث
    answers[qid] = aid; // إضافة أو تحديث {"QID": AID}
    print('After update - Answers: $answers'); // Log بعد التحديث

    emit(UpdateSelectedAnswer());
  }

  bool canGoToNextPage() {
    if (currentPage >= totalPages ) return false;

    final startIndex = currentPage * 3;
    final endIndex = startIndex + 3 > listOfQuestions.length
        ? listOfQuestions.length
        : startIndex + 3;

    for (int i = startIndex; i < endIndex; i++) {
      if (!selectedAnswers.containsKey(i)) {
        return false;
      }
    }
    return true;
  }

  void goToNextPage() {
    if (canGoToNextPage()) {
      currentPage++;
      emit(UpdatePageState());
    }
  }

  void goToPreviousPage() {
    if (currentPage > 0) {
      currentPage--;
      emit(UpdatePageState());
    }
  }
}