class ChatDataEntity {
  final int chatId;
  final String userPrompt;
  final String botResponse;

  const ChatDataEntity({
    required this.chatId,
    required this.userPrompt,
    required this.botResponse,
  });
}