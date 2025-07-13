import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_item_entity.dart';
import 'package:graduationproject/features/chatbot/presentation/views/chat_details_view.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/skeletone_loader.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/delete_chat_cubit.dart';

class ChatsListWidget extends StatelessWidget {
  final List<ChatItemEntity> chats;

  const ChatsListWidget({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteChatCubit, DeleteChatState>(
      builder: (context, deleteChatState) {
        final isDeleting = deleteChatState is DeleteChatLoading;

        return isDeleting
            ? const SkeletonLoaderWidget()
            : ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall, horizontal: Dimensions.paddingMedium),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
                title: AutoSizeText(
                  minFontSize: 0,
                  chat.title,
                  style: AppStyles.text14Bold,
                ),
                subtitle: AutoSizeText(
                  minFontSize: 0,
                  DateFormat('dd MMMM , hh:mm a', 'ar').format(DateTime.parse(chat.dateTime)),
                  style: AppStyles.text14Regular,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.secondaryColor,
                  ),
                  onPressed: () {
                    context.read<DeleteChatCubit>().deleteChat(id: chat.id);
                  },
                  tooltip: S.of(context).delete_chat,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ChatDetailView.routeName,
                    arguments: chat,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}