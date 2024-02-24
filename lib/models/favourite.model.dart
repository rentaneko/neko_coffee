class FavouriteModel {
  String? idProduct;
  String? idCustomer;
  String? imgUrl;
  String? name;
  String? desc;

  FavouriteModel.fromJson(dynamic json) {
    idProduct = json['id_product'] as String;
    idCustomer = json['id_user'] as String;
    imgUrl = json['Product']['img_url'] as String;
    name = json['Product']['name'] as String;
    desc = json['Product']['description'] as String;
  }

  FavouriteModel({
    this.desc,
    this.idCustomer,
    this.idProduct,
    this.imgUrl,
    this.name,
  });
}
