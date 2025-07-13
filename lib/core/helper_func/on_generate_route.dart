import 'package:flutter/material.dart';
import 'package:graduationproject/features/test/presentation/views/q_view.dart';
import 'package:graduationproject/features/test/presentation/views/select_tests.dart';
import 'package:graduationproject/features/test/presentation/views/show_more_about_tests.dart';
import 'package:graduationproject/features/auth/DeciderView.dart';
import 'package:graduationproject/features/auth/presentation/views/confirm_password.dart';
import 'package:graduationproject/features/auth/presentation/views/confirmation_code.dart';
import 'package:graduationproject/features/auth/presentation/views/forget_password_view.dart';
import 'package:graduationproject/features/auth/presentation/views/login_view.dart';
import 'package:graduationproject/features/auth/presentation/views/register_view.dart';
import 'package:graduationproject/features/auth/presentation/views/selection_screen.dart';
import 'package:graduationproject/features/blog/presentation/view/article.dart';
import 'package:graduationproject/features/blog/presentation/view/blog_view.dart';
import 'package:graduationproject/features/books/presentation/view/book_details_view.dart';
import 'package:graduationproject/features/books/presentation/view/book_view.dart';
import 'package:graduationproject/features/chatbot/presentation/views/chat_details_view.dart';
import 'package:graduationproject/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:graduationproject/features/community/presentation/view/community_view.dart';
import 'package:graduationproject/features/habits/domain/entity/store_habits_response_entity.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/habit_tracker_view.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/relaxation_view.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/score_view.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/tasks_view.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/yoga_stop_watch_view.dart';
import 'package:graduationproject/features/home/presentation/views/NavBar.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/mood_tracker_view.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/mood_tracker_view_by_date.dart';
import 'package:graduationproject/features/onboarding/presentation/views/on_boarding.dart';
import 'package:graduationproject/features/podcasts/presentation/view/podcast_details_view.dart';
import 'package:graduationproject/features/podcasts/presentation/view/podcasts_view.dart';
import 'package:graduationproject/features/test/presentation/views/test_view.dart';
import 'package:graduationproject/features/test/presentation/views/result_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RelaxationView.routeName:
      return MaterialPageRoute(
        builder: (_) => const RelaxationView(),
      );
    case BookView.routeName:
      return MaterialPageRoute(
        builder: (_) => const BookView(),
      );
    case BookDetailsView.routeName:
      final bookId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => BookDetailsView(bookId: bookId),
      );
    case YogaStopWatchView.routeName:
      return MaterialPageRoute(
        builder: (_) => const YogaStopWatchView(),
      );
    case ShowMoreAboutTests.routeName:
      return MaterialPageRoute(
        builder: (_) => const ShowMoreAboutTests(),
      );
    case BottomNavBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomNavBar(),
      );
    case ChatbotView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ChatbotView(),
      );
    case ScoreView.routeName:
      return MaterialPageRoute(
        builder: (_) => ScoreView(response: settings.arguments as StoreHabitsResponseEntity?),
      );
    case ChatDetailView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ChatDetailView(),
        settings: settings,
      );
    case ArticleView.routeName:
      return MaterialPageRoute(
        builder: (_) => ArticleView(id: settings.arguments as int),
      );
    case BlogView.routeName:
      return MaterialPageRoute(
        builder: (_) => BlogView(),
      );
    case MoodTrackerViewByDate.routeName:
      return MaterialPageRoute(
        builder: (_) => const MoodTrackerViewByDate(),
      );
    case ResultView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ResultView(),
      );
    case PodcastDetailsView.routeName:
      final podcastId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => PodcastDetailsView(podcastId: podcastId),
      );
    case RegisterView.routeName:
      return MaterialPageRoute(
        builder: (_) => const RegisterView(),
      );
    case SelectTest.routeName:
      return MaterialPageRoute(
        builder: (_) => const SelectTest(),
      );
    case QuestionsView.routeName:
      return MaterialPageRoute(
        builder: (_) => QuestionsView(),
      );
    case InitialView.routeName:
      return MaterialPageRoute(
        builder: (_) => const InitialView(),
      );
    case LoginView.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
      );
    case CommunityView.routeName:
      return MaterialPageRoute(
        builder: (_) => const CommunityView(),
      );
    case TestView.routeName:
      return MaterialPageRoute(
        builder: (_) => const TestView(),
      );
    case PodcastsView.routeName:
      return MaterialPageRoute(
        builder: (_) => const PodcastsView(),
      );

    case HabitTrackerView.routeName:
      return MaterialPageRoute(
        builder: (_) => const HabitTrackerView(),
      );
    case TasksView.routeName:
      return MaterialPageRoute(
        builder: (_) => TasksView(),
      );
    case SelectionScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SelectionScreen(),
      );
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ForgetPasswordView(),
      );
    case MoodTrackerView.routeName:
      return MaterialPageRoute(
        builder: (_) => const MoodTrackerView(),
      );
    case ConfirmationCodeView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ConfirmationCodeView(),
      );
    case ConfirmationPassword.routeName:
      return MaterialPageRoute(
        builder: (_) => const ConfirmationPassword(),
      );
    case OnBoardingView.routeName:
      return MaterialPageRoute(
        builder: (_) => const OnBoardingView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}