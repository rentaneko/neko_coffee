class SubCategoryModel {
  String? id;
  String? idParent;
  String? name;
  String? icon;

  SubCategoryModel({this.id, this.idParent, this.name, this.icon});

  SubCategoryModel.fromJson(dynamic json) {
    id = json['id'] as String;
    idParent = json['id_parent'] as String;
    name = json['name'] as String;
    icon = json['icon_url'] as String;
  }
}
