import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_item_entity.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/create_chat_button.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/empty_state_widget.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/skeletone_loader.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/create_new_chat_cubit.dart';
import '../../controller/cubits/delete_chat_cubit.dart';
import '../../controller/cubits/get_chats_list_cubit.dart';
import '../../controller/cubits/local_chats_list_cubit.dart';
import 'chat_list_widget.dart';

class ChatBotViewBody extends StatelessWidget {
  const ChatBotViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalChatsListCubit, LocalChatsListState>(
      builder: (context, localState) {
        int nextChatNumber = 1;
        List<ChatItemEntity> chats = [];

        if (localState is LocalChatsListSuccess) {
          chats = localState.chats;
          nextChatNumber = chats.length + 1;
        } else if (localState is LocalChatsListEmpty) {
          chats = [];
        }

        final isLoading = localState is LocalChatsListLoading ||
            context.watch<CreateAndSendCubit>().state is CreateAndSendLoading ||
            context.watch<DeleteChatCubit>().state is DeleteChatLoading;

        return Column(
          children: [
            Expanded(
              child: isLoading
                  ? const SkeletonLoaderWidget()
                  : chats.isEmpty
                  ? EmptyNoData(
                height: Dimensions.boxHeight200,
              )
                  : ChatsListWidget(chats: chats),
            ),
            CreateChatButton(nextChatNumber: nextChatNumber),
          ],
        );
      },
    );
  }
}