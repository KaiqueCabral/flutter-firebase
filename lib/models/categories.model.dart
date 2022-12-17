class CategoryModel {
  String? id;
  late String name;
  late String uid;

  CategoryModel({this.id, required this.name, required this.uid});

  CategoryModel.fromJson(Map<String, dynamic> json, String? id) {
    this.id = id ?? "";
    name = json['name'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uid'] = uid;
    return data;
  }
}
