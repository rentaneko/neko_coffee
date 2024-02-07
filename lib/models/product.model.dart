class ProductModel {
  String? id;
  String? name;
  String? imgUrl;
  String? desc;
  int? quantity;
  double? price;
  String? idCategory;

  ProductModel.fromJson(dynamic json) {
    id = json['id'] as String;
    name = json['name'] as String;
    imgUrl = json['img_url'] as String;
    desc = json['description'] as String;
    idCategory = json['id_category'] as String;
    quantity = json['quantity'] as int;
    price = json['price'] as double;
  }

  ProductModel({
    this.desc,
    this.id,
    this.idCategory,
    this.imgUrl,
    this.name,
    this.price,
    this.quantity,
  });
}
