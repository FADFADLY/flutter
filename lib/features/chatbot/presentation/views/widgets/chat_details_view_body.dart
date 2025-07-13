import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_item_entity.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/message_input.dart';
import 'chat_content.dart';

class ChatDetailsViewBody extends StatelessWidget {
  final ChatItemEntity chat;

  const ChatDetailsViewBody({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Expanded(child: ChatContent(chatId: chat.id)),
          MessageInput(chatId: chat.id),
        ],
      ),
    );
  }
}