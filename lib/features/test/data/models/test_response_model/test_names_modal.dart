import 'package:graduationproject/features/test/data/models/test_response_model/test_names_data_modal.dart';

class TestsNamesModel {
  bool? success;
  String? message;
  List<TestNamesDataModal>? data;
  Null? errors;
  int? code;

  TestsNamesModel(
      {this.success, this.message, this.data, this.errors, this.code});

  TestsNamesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TestNamesDataModal>[];
      json['data'].forEach((v) {
        data!.add(new TestNamesDataModal.fromJson(v));
      });
    }
    errors = json['errors'];
    code = json['code'];
  }


}

