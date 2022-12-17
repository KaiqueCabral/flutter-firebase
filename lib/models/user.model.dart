class UserModel {
  final String uid;
  final String? name;
  final String email;
  UserModel({required this.uid, this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
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
