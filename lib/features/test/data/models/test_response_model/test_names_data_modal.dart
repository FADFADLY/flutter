
import '../../../domain/entities/tests/test_entity.dart';

class TestNamesDataModal extends TestEntity {
  int id;
  String name;

  TestNamesDataModal({required this.id, required this.name}) : super(id: id, name: name);

  factory TestNamesDataModal.fromJson(Map<String, dynamic> json) {
    return
      TestNamesDataModal(id: json['id'], name: json['name']);
  }

}
