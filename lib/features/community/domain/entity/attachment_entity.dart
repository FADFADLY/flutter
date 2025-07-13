 class AttachmentEntity {
  final int? id;
  final List<OptionsEntity>? options; // تغيير من option إلى options
  final String? latitude;
  final String? longitude;
  final String? label;
  final String? title;
  final String? author;
  final String? image;
  final String? createdAt;
  final int? views;
  final int? likes;
  final int? share;
  final bool? reacted;
  final int? totalVotes; // إضافة هذا الحقل الجديد

  const AttachmentEntity({
    this.id,
    this.options,
    this.latitude,
    this.longitude,
    this.label,
    this.title,
    this.author,
    this.image,
    this.createdAt,
    this.views,
    this.likes,
    this.share,
    this.reacted,
    this.totalVotes,
  });
}

class OptionsEntity {
  final int id;
  final String option;
  final num percentage;
  final int votes;
  final bool voted;

  const OptionsEntity({
    required this.id,
    required this.option,
    required this.percentage,
    required this.votes,
    required this.voted,
  });
}