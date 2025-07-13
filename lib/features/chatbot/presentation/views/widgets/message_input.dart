import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/create_new_chat_cubit.dart';

class MessageInput extends StatelessWidget {
  final int? chatId;

  const MessageInput({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium, vertical: Dimensions.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: S.of(context).write_message,
                hintStyle: AppStyles.text14Regular.copyWith(color:  Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor:  Colors.grey.withOpacity(0.1),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium, vertical: Dimensions.paddingMedium),
              ),
            ),
          ),
          SizedBox(width: Dimensions.boxHeight8),
          CircleAvatar(
            radius: Dimensions.socialIconSize,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              icon: Icon(Icons.send, color: AppColors.whiteColor, size: Dimensions.iconSize),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  context.read<CreateAndSendCubit>().createNewChat(
                    userPrompt: controller.text,
                    chatId: chatId,
                  );
                  controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}