class CategoryModel {
  String? id;
  String? name;

  CategoryModel.fromJson(dynamic json) {
    id = json['id'] as String;
    name = json['name'] as String;
  }

  CategoryModel({this.id, this.name});
}
