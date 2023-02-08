class StudentModel {
  String? id;
  String? name;
  String? diagnose;
  String? age;
  String? profileImg;

  StudentModel({
    this.id,
    this.name,
    this.diagnose,
    this.age,
    this.profileImg,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'diagnose': diagnose,
      'profile_img': profileImg,
    };
  }

  factory StudentModel.fromJson(dynamic json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      diagnose: json['diagnose'],
      profileImg: json['profile_img'],
    );
  }
}
