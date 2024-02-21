class CategoryModel {
  String? id;
  String? name;
  String? icon;

  CategoryModel.fromJson(dynamic json) {
    id = json['id'] as String;
    name = json['name'] as String;
    icon = json['icon_url'] as String;
  }

  CategoryModel({this.id, this.name, this.icon});
}
