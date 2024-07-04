// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neko_coffee/core/entities/cart.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required super.idProduct,
    required super.iceType,
    required super.variantType,
    required super.sizeCup,
    required super.sugarType,
    required super.quantity,
    super.idUser,
    super.id,
    required super.totalAmount,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      idProduct: map['id_product'] as String,
      iceType: map['ice_type'] as String,
      variantType: map['variant_type'] as String,
      sizeCup: map['size_cup'] as String,
      sugarType: map['sugar_type'] as String,
      quantity: map['quantity'] as int,
      idUser: map['id_user'] as String,
      id: map['id'] as String,
      totalAmount: map['total'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id_product': idProduct,
      'id': id,
      'ice_type': iceType,
      'variant_type': variantType,
      'size_cup': sizeCup,
      'sugar_type': sugarType,
      'quantity': quantity,
      'id_user': idUser,
      'total': totalAmount,
    };
  }
}
