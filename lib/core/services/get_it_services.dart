import 'package:get_it/get_it.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/services/remote/habit_services.dart';
import 'package:graduationproject/core/services/remote/mood_service.dart';
import 'package:graduationproject/core/services/remote/posts.dart';
import 'package:graduationproject/core/services/remote/profile.dart';
import 'package:graduationproject/core/services/remote/tests_service.dart';
import 'package:graduationproject/core/services/local/chat_local_storage.dart';
import 'package:graduationproject/core/services/remote/book_service.dart';
import 'package:graduationproject/core/services/remote/blog.dart';
import 'package:graduationproject/core/services/remote/chat_service.dart';
import 'package:graduationproject/core/services/remote/podcast_service.dart';
import 'package:graduationproject/core/services/remote/notification_service.dart'; // إضافة استيراد NotificationService
import 'package:graduationproject/features/auth/data/repo/repo_impl.dart';
import 'package:graduationproject/features/blog/domain/repo/repo.dart';
import 'package:graduationproject/features/mood_tracker/domain/repo/repo.dart';
import 'package:graduationproject/features/test/domain/repo/repo.dart';
import 'package:graduationproject/features/books/domain/repo/book_repo.dart';
import 'package:graduationproject/features/blog/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/chatbot/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/chatbot/domain/repo/repo.dart';
import 'package:graduationproject/features/habits/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/habits/domain/repo/repo.dart';
import 'package:graduationproject/features/mood_tracker/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/test/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/books/data/repo_impl/book_repo_impl.dart';
import 'package:graduationproject/features/profile/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/profile/domain/repo/repo.dart';
import 'package:graduationproject/features/podcasts/domain/repo/podcast_repo.dart';
import 'package:graduationproject/features/podcasts/data/repo_impl/podcast_repo_impl.dart';
import 'package:graduationproject/features/community/data/repo_impl/repo_impl.dart';
import 'package:graduationproject/features/community/domain/repo/repo.dart';

import '../../features/notifications/data/repo_impl/repo_impl.dart';
import '../../features/notifications/domain/repo/repo.dart'; // إضافة استيراد NotificationRepo

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authService: getIt<AuthService>()),
  );
  getIt.registerSingleton<TestsService>(TestsService());
  getIt.registerSingleton<TestRepository>(
    TestRepositoryImplementation(testsService: getIt<TestsService>()),
  );
  getIt.registerSingleton<MoodService>(
    MoodService(),
  );
  getIt.registerSingleton<MoodTrackerRepo>(
    MoodTrackerRepoImpl(moodService: getIt<MoodService>()),
  );
  getIt.registerSingleton<BlogService>(
    BlogService(),
  );
  getIt.registerSingleton<BlogRepo>(
    BlogRepoImpl(blogService: getIt<BlogService>()),
  );
  getIt.registerSingleton<ChatBotService>(
    ChatBotService(),
  );
  getIt.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(chatBotService: getIt<ChatBotService>()),
  );
  getIt.registerSingleton<ChatLocalStorage>(ChatLocalStorage());
  getIt.registerSingleton<HabitService>(
    HabitService(),
  );
  getIt.registerSingleton<HabitRepo>(
    HabitRepoImpl(habitService: getIt<HabitService>()),
  );
  getIt.registerSingleton<BookService>(
    BookService(),
  );
  getIt.registerSingleton<BookRepo>(
    BookRepoImpl(bookService: getIt<BookService>()),
  );
  getIt.registerSingleton<ProfileService>(
    ProfileService(),
  );
  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(profileService: getIt<ProfileService>()),
  );
  getIt.registerSingleton<PodcastService>(
    PodcastService(),
  );
  getIt.registerSingleton<PodcastRepo>(
    PodcastRepoImpl(podcastService: getIt<PodcastService>()),
  );
  getIt.registerSingleton<PostsService>(
    PostsService(),
  );
  getIt.registerSingleton<PostsRepo>(
    PostsRepoImpl(postsService: getIt<PostsService>()),
  );
  // إضافة تسجيل NotificationService و NotificationRepo
  getIt.registerSingleton<NotificationService>(
    NotificationService(),
  );
  getIt.registerSingleton<NotificationRepo>(
    NotificationRepoImpl(notificationService: getIt<NotificationService>()),
  );
}