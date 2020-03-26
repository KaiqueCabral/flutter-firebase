class CategoryModel {
  String id;
  String name;
  String uid;

  CategoryModel({this.id, this.name, this.uid});

  CategoryModel.fromJson(Map<String, dynamic> json, String documentID) {
    id = documentID ?? "";
    name = json['name'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    return data;
  }
}
