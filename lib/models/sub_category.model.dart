class SubCategoryModel {
  String? id;
  String? idParent;
  String? name;

  SubCategoryModel({this.id, this.idParent, this.name});

  SubCategoryModel.fromJson(dynamic json) {
    id = json['id'] as String;
    idParent = json['id_parent'] as String;
    name = json['name'] as String;
  }
}
