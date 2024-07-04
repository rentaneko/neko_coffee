part of 'add_to_cart_bloc.dart';

@immutable
sealed class AddToCartEvent {
  const AddToCartEvent();
}

@immutable
sealed class AddToCartActionEvent extends AddToCartEvent {
  const AddToCartActionEvent();
}

final class InitialAddToCartEvent extends AddToCartEvent {
  final String idCate;
  final String idProduct;

  const InitialAddToCartEvent({required this.idCate, required this.idProduct});
}

final class UpdateSizeCupEvent extends AddToCartEvent {
  final String type;
  const UpdateSizeCupEvent({required this.type});
}

final class UpdateSugarTypeEvent extends AddToCartEvent {
  final String type;

  const UpdateSugarTypeEvent({required this.type});
}

final class UpdateVariantEvent extends AddToCartEvent {
  final String type;
  const UpdateVariantEvent({required this.type});
}

final class UpdateIceTypeEvent extends AddToCartEvent {
  final String type;
  const UpdateIceTypeEvent({required this.type});
}

final class AddItemToCartEvent extends AddToCartActionEvent {
  final String idProduct;
  final double price;

  const AddItemToCartEvent({required this.idProduct, required this.price});
}
