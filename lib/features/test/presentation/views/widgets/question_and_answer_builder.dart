import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/questions_and_answers.dart';
import '../../controller/cubits/question_cubit/questions_cubit.dart';
import 'display_answer.dart';

class QuestionAndAnswersBuilder extends StatelessWidget {
  const QuestionAndAnswersBuilder({
    super.key,
    required this.cubit,
    required this.pageIndex,
  });

  final QuestionsCubit cubit;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cubit.groupedQuestions[pageIndex].length,
      itemBuilder: (context, offset) {
        final questionIndex = pageIndex * 3 + offset;
        final question = cubit.groupedQuestions[pageIndex][offset];
        final answers = cubit.groupedAnswers[pageIndex][offset];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionAndNumber(
              questionIndex: questionIndex,
              cubit: cubit,
              question: question,
            ),
            SizedBox(height: Dimensions.boxHeight20),
            BlocBuilder<QuestionsCubit, QuestionsState>(
              buildWhen: (previous, current) =>
              current is UpdateSelectedAnswer || current is QuestionsSuccess,
              builder: (context, state) {
                final selectedAnswer = cubit.selectedAnswers[questionIndex];
                return DisplayAnswers(
                  answers: answers,
                  selectedAnswer: selectedAnswer,
                  cubit: cubit,
                  questionIndex: questionIndex,
                );
              },
            ),
            SizedBox(height: Dimensions.boxHeight20),
          ],
        );
      },
    );
  }
}