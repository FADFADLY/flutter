
import '../../domain/entity/habit_data_entity.dart';

class HabitModel extends HabitDataEntity {
  const HabitModel({
    required int id,
    required String name,
    required String icon,
  }) : super(
          id: id,
          name: name,
          icon: icon,
        );

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
      };
}