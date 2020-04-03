class UserModel {
  final String uid;
  final String name;
  final String email;
  UserModel({this.uid, this.name, this.email});

  factory UserModel.fromMap(Map<String, dynamic> json) => new UserModel(
        uid: json["uid"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
