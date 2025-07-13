abstract class ChatMessageEntity {
  final String prompt;
  final String response;
  final String dateTime;

  const ChatMessageEntity({required this.prompt, required this.response, required this.dateTime});
}