import 'package:labbaik/app/1auth/model/student.dart';

class StaffsModel {
  String? id;
  String? name;
  String? lname;
  String? jobTitle;
  String? exp;
  String? profileImg;
  String? phone;
  List<StudentModel>? assignedStudent;

  StaffsModel({
    this.id,
    this.name,
    this.lname,
    this.jobTitle,
    this.profileImg,
    this.exp,
    this.phone,
    this.assignedStudent
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,

      'jobTitle': jobTitle,
      'lname': lname,
      'profile_img': profileImg,
      'phone': phone,
      'exp': exp,
      'assigned_student': assignedStudent == null ? [] : List<StudentModel>.from(assignedStudent!.map((x) => x)),
    };
  }

  factory StaffsModel.fromJson(dynamic json) {
    return StaffsModel(
      id: json['id'],
      name: json['name'],
      jobTitle: json['jobTitle'],

      lname: json['lname'],
      profileImg: json['profile_img'],
      phone: json['phone'],
      exp: json['exp'],
      // myChildren: json["my_children"] == null ? [] : List<StudentModel>.from(json["my_children"]!.map((x) => x)),
    );
  }
}
