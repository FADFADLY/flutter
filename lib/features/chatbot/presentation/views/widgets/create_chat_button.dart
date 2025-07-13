import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/create_new_chat_cubit.dart';

class CreateChatButton extends StatelessWidget {
  final int nextChatNumber;

  const CreateChatButton({super.key, required this.nextChatNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.paddingMedium),
      child: ElevatedButton(
        onPressed: () {
          context.read<CreateAndSendCubit>().createNewChat(
            userPrompt: 'محادثة $nextChatNumber',
          );
        },
        style: AppStyles.buttonStyle2,
        child: AutoSizeText(
          minFontSize: 0,
          S.of(context).create_new_chat,
          style: AppStyles.text18Button.copyWith(
            color: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}