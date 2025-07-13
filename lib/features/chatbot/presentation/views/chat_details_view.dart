import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_item_entity.dart';
import 'package:graduationproject/features/chatbot/presentation/controller/cubits/create_new_chat_cubit.dart';
import 'package:graduationproject/features/chatbot/presentation/controller/cubits/local_chat_cubit.dart';
import 'package:graduationproject/features/chatbot/presentation/controller/cubits/local_chats_list_cubit.dart';
import 'package:graduationproject/features/chatbot/presentation/controller/cubits/restore_old_chat_cubit.dart';
import 'package:graduationproject/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/chat_details_view_body.dart';
import '../../../../core/services/local/chat_local_storage.dart';
import '../../domain/repo/repo.dart';

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({super.key});

  static const routeName = '/chat-details';

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments is! ChatItemEntity) {
      return Scaffold(
        body: Center(
          child: AutoSizeText(
            minFontSize: 0,
            S.of(context).invalid_chat_data,
            style: AppStyles.text16Regular,
          ),
        ),
      );
    }
    final chat = arguments;

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: chat.title,
        navigateTo: ChatbotView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: MultiBlocProvider(
        providers: [
          // LocalChatCubit: مسؤول عن عرض الرسائل من Hive
          BlocProvider(
            create: (_) => LocalChatCubit(localStorage: getIt<ChatLocalStorage>()),
          ),

          // LocalChatsListCubit: لعرض كل المحادثات
          BlocProvider(
            create: (_) => LocalChatsListCubit(
              localStorage: getIt<ChatLocalStorage>(),
              chatRepository: getIt<ChatRepository>(),
            )..getLocalChatsList(),
          ),

          // RestoreOldChatCubit: يسترجع الرسائل القديمة من API ويخزنها ثم ينادي LocalChatCubit
          BlocProvider(
            create: (context) => RestoreOldChatCubit(
              chatRepository: getIt<ChatRepository>(),
              localChatCubit: context.read<LocalChatCubit>(),
            )..getOldMessages(chatId: chat.id),
          ),
          // CreateAndSendCubit: لإرسال رسائل جديدة
          BlocProvider(
            create: (context) => CreateAndSendCubit(
              chatRepository: getIt<ChatRepository>(),
              localChatCubit: context.read<LocalChatCubit>(),
              localChatsListCubit: context.read<LocalChatsListCubit>(),
            ),
          ),
        ],
        child: ChatDetailsViewBody(chat: chat),
      ),
    );
  }
}
