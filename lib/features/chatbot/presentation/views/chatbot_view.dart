import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/services/local/chat_local_storage.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/chatbot_view_body.dart';
import 'package:graduationproject/features/home/presentation/views/NavBar.dart';
import '../../../../core/services/get_it_services.dart';
import '../../../../core/shared_widgets/custom_app_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../generated/l10n.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/create_new_chat_cubit.dart';
import '../controller/cubits/delete_chat_cubit.dart';
import '../controller/cubits/get_chats_list_cubit.dart';
import '../controller/cubits/local_chat_cubit.dart';
import '../controller/cubits/local_chats_list_cubit.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  static const routeName = '/chatbot';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalChatCubit(
            localStorage: getIt<ChatLocalStorage>(),
          ),
        ),
        BlocProvider(
          create: (context) => LocalChatsListCubit(
            chatRepository: getIt<ChatRepository>(),
            localStorage: getIt<ChatLocalStorage>(),
          )..getLocalChatsList(),
        ),
        BlocProvider(
          create: (context) => CreateAndSendCubit(
            chatRepository: getIt<ChatRepository>(),
            localChatCubit: context.read<LocalChatCubit>(),
            localChatsListCubit: context.read<LocalChatsListCubit>(),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => GetChatsListCubit(
            chatRepository: getIt<ChatRepository>(),
            localStorage: getIt<ChatLocalStorage>(),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteChatCubit(
            chatRepository: getIt<ChatRepository>(),
            localStorage: getIt<ChatLocalStorage>(),
            localChatsListCubit: context.read<LocalChatsListCubit>(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).chatbot,
          navigateTo: BottomNavBar.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<CreateAndSendCubit, CreateAndSendState>(
              listener: (context, state) {
                if (state is CreateAndSendSuccess) {
                  context.read<GetChatsListCubit>().getChatsList();
                } else if (state is CreateAndSendFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AutoSizeText(
                        minFontSize: 0,
                        state.message,
                        style: AppStyles.text16Regular,
                      ),
                    ),
                  );
                }
              },
            ),
            BlocListener<DeleteChatCubit, DeleteChatState>(
              listener: (context, state) {
                if (state is DeleteChatSuccess) {
                  context.read<GetChatsListCubit>().getChatsList();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AutoSizeText(
                        minFontSize: 0,
                        state.message,
                        style: AppStyles.text16Regular,
                      ),
                    ),
                  );
                } else if (state is DeleteChatError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AutoSizeText(
                        minFontSize: 0,
                        state.message,
                        style: AppStyles.text16Regular,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: const ChatBotViewBody(),
        ),
      ),
    );
  }
}