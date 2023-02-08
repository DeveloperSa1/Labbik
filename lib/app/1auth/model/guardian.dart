class GuardianModel {
  String? id;
  String? uid;
  String? name;
  String? phone;
  List<dynamic>? myChildren;

  GuardianModel({
    this.id,
    this.uid,
    this.name,
    this.phone,
    this.myChildren,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'my_children': myChildren,
      'phone': phone,
    };
  }

  factory GuardianModel.fromJson(dynamic json) {
    return GuardianModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      myChildren: json['my_children'],
      uid: json['uid'],
    );
  }
}
