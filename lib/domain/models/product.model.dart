import 'package:neko_coffee/core/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.ingredient,
    required super.iconUrl,
    required super.price,
    required super.discount,
    required super.isPromo,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      ingredient: map['ingredient'] as String,
      iconUrl: map['icon_url'] as String,
      price: double.parse(map['price'].toString()),
      discount: double.parse(map['discount'].toString()),
      isPromo: map['is_promo'] as bool,
      category: map['category'] as String,
    );
  }

  ProductModel copyWith({
    String? newId,
    String? newName,
    String? newIngredient,
    String? newIcon,
    double? newPrice,
    double? newDiscount,
    bool? newPromo,
    String? category,
  }) {
    return ProductModel(
      id: newId ?? id,
      name: newName ?? name,
      ingredient: newIngredient ?? ingredient,
      iconUrl: newIcon ?? iconUrl,
      price: newPrice ?? price,
      discount: newDiscount ?? discount,
      isPromo: newPromo ?? isPromo,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ingredient': ingredient,
      'icon_url': iconUrl,
      'price': price,
      'discount': discount,
      'is_promo': isPromo,
      'category': category,
    };
  }
}
