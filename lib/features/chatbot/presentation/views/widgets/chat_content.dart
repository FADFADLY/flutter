import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/create_new_chat_cubit.dart';
import '../../controller/cubits/local_chat_cubit.dart';
import '../../controller/cubits/restore_old_chat_cubit.dart';
import '../../../data/model/chat_messages_api_response_model.dart';
import 'message_bubble.dart';
import 'typing_bubble.dart';

class ChatContent extends StatefulWidget {
  final int chatId;

  const ChatContent({super.key, required this.chatId});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<RestoreOldChatCubit>().getOldMessages(chatId: widget.chatId);

    context.read<CreateAndSendCubit>().stream.listen((state) {
      if (state is CreateAndSendSuccess) {
        _scrollToBottom();
      }
    });

    context.read<LocalChatCubit>().stream.listen((state) {
      if (state is LocalChatSuccess) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateAndSendCubit, CreateAndSendState>(
          listener: (context, state) {
            if (state is CreateAndSendFailure) {
              _showSnackBar(context, state.message, isError: true);
            }
          },
        ),
      ],
      child: BlocBuilder<RestoreOldChatCubit, RestoreOldChatState>(
        builder: (context, restoreState) {
          final isRestoring = restoreState is RestoreOldChatLoading;

          return BlocBuilder<LocalChatCubit, LocalChatState>(
            builder: (context, localState) {
              final isLoading = localState is LocalChatLoading || isRestoring;

              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primaryColor),
                );
              }

              if (localState is LocalChatSuccess) {
                return ValueListenableBuilder(
                  valueListenable: Hive.box<ChatMessagesApiResponseModel>('chatResponse_${widget.chatId}').listenable(),
                  builder: (context, box, _) {
                    final response = box.get('response');
                    final messages = response?.data ?? [];

                    final createState = context.watch<CreateAndSendCubit>().state;

                    if (messages.isEmpty && createState is! CreateAndSendLoading) {
                      return EmptyNoData(height: Dimensions.boxHeight200);
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(Dimensions.paddingMedium),
                      itemCount: messages.length * 2 +
                          (createState is CreateAndSendLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (createState is CreateAndSendLoading &&
                            index == messages.length * 2) {
                          return const TypingBubble();
                        }

                        final messageIndex = index ~/ 2;
                        final isPrompt = index % 2 == 0;

                        if (messageIndex >= messages.length) return const SizedBox.shrink();

                        final message = messages[messageIndex];
                        final text = isPrompt ? message.prompt : message.response;

                        if (text.isEmpty) return const SizedBox.shrink();

                        return MessageBubble(message: message, isPrompt: isPrompt);
                      },
                    );
                  },
                );
              }

              return Column(
                children: [
                  Expanded(child: EmptyNoData(height: Dimensions.boxHeight200)),
                  if (localState is LocalChatError)
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.paddingLarge),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LocalChatCubit>().getLocalMessages(widget.chatId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingMedium,
                            vertical: Dimensions.paddingMedium,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                          ),
                        ),
                        child: AutoSizeText(
                          minFontSize: 0,
                          S.of(context).try_again,
                          style: AppStyles.text18Button.copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AutoSizeText(
          minFontSize: 0,
          message,
          style: AppStyles.text16Regular,
        ),
        backgroundColor: isError ? AppColors.errorColor : null,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
