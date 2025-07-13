import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_message_entity.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/dimensions.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isPrompt;

  const MessageBubble({super.key, required this.message, required this.isPrompt});

  @override
  Widget build(BuildContext context) {
    final isUserMessage = isPrompt;

    String formattedDateTime;
    try {
      final dateTime = DateTime.parse(message.dateTime).toLocal();
      formattedDateTime = DateFormat('dd MMMM , hh:mm a', 'ar').format(dateTime);
    } catch (e) {
      formattedDateTime = S.of(context).unknown;
    }

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall, horizontal: Dimensions.paddingMedium),
        padding: EdgeInsets.all(Dimensions.paddingMedium),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUserMessage ? AppColors.primaryColor : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium).copyWith(
            topLeft: isUserMessage ?  Radius.circular(Dimensions.borderRadiusMedium) : const Radius.circular(0),
            topRight: isUserMessage ? const Radius.circular(0) :  Radius.circular(Dimensions.borderRadiusMedium),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              minFontSize: 0,
              isPrompt ? message.prompt : message.response,
              style: AppStyles.text14Regular.copyWith(
                color: isUserMessage ? AppColors.whiteColor : AppColors.textColor,
              ),
            ),
            SizedBox(height: Dimensions.boxHeight6),
            AutoSizeText(
              minFontSize: 0,
              formattedDateTime,
              style: AppStyles.text12Regular.copyWith(
                color: isUserMessage ? AppColors.whiteColor.withOpacity(0.7) : AppColors.textColor.withOpacity(0.54),
                fontSize: Dimensions.fontSize10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}