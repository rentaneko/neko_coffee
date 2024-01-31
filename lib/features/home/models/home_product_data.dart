class ProductDataModel {
  late String id;
  late String name;
  String? desc;
  late double price;
  late String imgUrl;

  ProductDataModel.fromJson(dynamic json) {
    id = json['id'] as String;
    name = json['name'] as String;
    desc = json['description'] as String;
    imgUrl = json['img_url'] as String;
    price = json['price'] as double;
  }

  ProductDataModel({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.imgUrl,
  });
}
