import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CartItem extends Equatable {
  String id;
  final String idProduct;
  final List<String>? idTopping;
  final String iceType;
  final String variantType;
  final String sizeCup;
  final String sugarType;
  final int quantity;
  String? idUser;

  CartItem({
    required this.id,
    required this.idProduct,
    required this.idTopping,
    required this.iceType,
    required this.variantType,
    required this.sizeCup,
    required this.sugarType,
    required this.quantity,
    this.idUser,
  });

  @override
  List<Object?> get props => [
        idTopping,
        iceType,
        variantType,
        sizeCup,
        sugarType,
      ];
}
