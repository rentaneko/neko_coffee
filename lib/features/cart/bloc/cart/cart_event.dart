part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

final class AddToCartEvent extends CartEvent {
  final String idProduct;
  final List<String> idTopping;
  final String iceType;
  final String variantType;
  final String sizeCup;
  final String sugarType;
  final int quantity;

  const AddToCartEvent({
    required this.idProduct,
    required this.idTopping,
    required this.iceType,
    required this.variantType,
    required this.sizeCup,
    required this.sugarType,
    required this.quantity,
  });
}

final class CartInitialEvent extends CartEvent {}
