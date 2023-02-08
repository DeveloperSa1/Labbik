class AdminModel {
  String? name;
  String? userId;
  String? email;
  String? image;
  String? id;
  String? password;
  String? userType;

  AdminModel(
      {this.name,
        this.userId,
        this.email,
        this.id,
        this.image,
        this.password,
        this.userType});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'user_id': userId,
      'email': email,
      'image': image,
      'user_type': userType,
      'password': password,
    };
  }

  factory AdminModel.fromJson(dynamic json) {
    return AdminModel(
      name: json['name'],
      id: json['id'],
      userId: json['user_id'],
      email: json['email'],
      image: json['image'],
      password: json['password'],
    );
  }
}

