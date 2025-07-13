abstract class ChatItemEntity {
  final int id;
  final String title;
  final String dateTime;

  const ChatItemEntity({
    required this.id,
    required this.title,
    required this.dateTime,
  });
}