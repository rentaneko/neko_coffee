import 'package:neko_coffee/core/entities/cart.dart';

// ignore: must_be_immutable
class CartItemModel extends CartItem {
  CartItemModel({
    required super.id,
    required super.idProduct,
    super.idTopping,
    required super.iceType,
    required super.variantType,
    required super.sizeCup,
    required super.sugarType,
    required super.quantity,
    super.idUser,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      idProduct: map['id_product'] as String,
      idTopping: List<String>.from(map['id_topping'] ?? []),
      iceType: map['ice_type'] as String,
      variantType: map['variant_type'] as String,
      sizeCup: map['size_cup'] as String,
      sugarType: map['sugar_type'] as String,
      quantity: map['quantity'] as int,
      idUser: map['id_user'] as String,
    );
  }

  CartItemModel copyWith({
    List<String>? idTopping,
    String? variantType,
    String? iceType,
    String? sizeCup,
    String? sugarType,
    int? quantity,
    String? idUser,
  }) {
    return CartItemModel(
      id: id,
      idProduct: idProduct,
      idTopping: idTopping ?? this.idTopping,
      iceType: iceType ?? this.iceType,
      variantType: variantType ?? this.variantType,
      sizeCup: sizeCup ?? this.sizeCup,
      sugarType: sugarType ?? this.sugarType,
      quantity: quantity ?? this.quantity,
      idUser: idUser ?? this.idUser,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id_product': idProduct,
      'id_topping': idTopping,
      'ice_type': iceType,
      'variant_type': variantType,
      'size_cup': sizeCup,
      'sugar_type': sugarType,
      'quantity': quantity,
      'id_user': idUser,
      'id': id,
    };
  }
}
