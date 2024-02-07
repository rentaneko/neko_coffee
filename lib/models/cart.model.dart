class CartModel {
  String? idUser;
  String? idProduct;
  String? name;
  double? price;
  String? imgUrl;
  String? idCategory;
  String? idSubCategory;
  int? quantity;

  CartModel.fromJson(dynamic json) {
    idUser = json['id_user'] as String;
    idProduct = json['id_product'] as String;
    quantity = json['quantity'] as int;
    name = json['Product']['name'] as String;
    imgUrl = json['Product']['img_url'] as String;
    idCategory = json['Product']['id_category'] as String;
    idSubCategory = json['Product']['id_sub_category'] as String;
    price = json['Product']['price'] as double;
  }

  CartModel({
    this.idProduct,
    this.idUser,
    this.quantity,
    this.idCategory,
    this.idSubCategory,
    this.imgUrl,
    this.name,
    this.price,
  });
}
