import 'package:neko_coffee/core/entities/topping.dart';

class ToppingModel extends Topping {
  ToppingModel({
    required super.id,
    required super.idCategory,
    required super.name,
    required super.price,
    required super.description,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      id: json['id'],
      idCategory: json['id_category'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}
