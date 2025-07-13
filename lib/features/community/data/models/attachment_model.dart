import '../../domain/entity/attachment_entity.dart';

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    int? id,
    List<OptionsEntity>? options,
    String? latitude,
    String? longitude,
    String? label,
    String? title,
    String? author,
    String? image,
    String? createdAt,
    int? views,
    int? likes,
    int? share,
    bool? reacted,
    int? totalVotes,
  }) : super(
    id: id,
    options: options,
    latitude: latitude,
    longitude: longitude,
    label: label,
    title: title,
    author: author,
    image: image,
    createdAt: createdAt,
    views: views,
    likes: likes,
    share: share,
    reacted: reacted,
    totalVotes: totalVotes,
  );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    List<OptionsEntity>? options;
    if (json['options'] != null && json['options'] is List) {
      options = (json['options'] as List).map((option) {
        return OptionsEntity(
          id: option['id'] ?? 0,
          option: option['option'] ?? '',
          percentage: option['percentage'] ?? 0,
          votes: option['votes'] ?? 0,
          voted: option['voted'] ?? false,
        );
      }).toList();
    }

    return AttachmentModel(
      id: json['id'],
      options: options,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      label: json['label'] as String?,
      title: json['title'] as String?,
      author: json['author'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      views: json['views'] as int?,
      likes: json['likes'] as int?,
      share: json['share'] as int?,
      reacted: json['reacted'] as bool?,
      totalVotes: json['total_votes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (options != null)
        'options': options!.map((option) {
          return {
            'id': option.id,
            'option': option.option,
            'percentage': option.percentage,
            'votes': option.votes,
            'voted': option.voted,
          };
        }).toList(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (label != null) 'label': label,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (image != null) 'image': image,
      if (createdAt != null) 'created_at': createdAt,
      if (views != null) 'views': views,
      if (likes != null) 'likes': likes,
      if (share != null) 'share': share,
      if (reacted != null) 'reacted': reacted,
      if (totalVotes != null) 'total_votes': totalVotes,
    };
  }
}