part of 'add_to_cart_bloc.dart';

@immutable
sealed class AddToCartState {
  const AddToCartState();
}

final class AddToCartInitial extends AddToCartState {}

final class AddToCartLoading extends AddToCartState {}

final class AddToCartFailure extends AddToCartState {
  final ServerError error;

  const AddToCartFailure({required this.error});
}

final class AddToCartDisplaySuccess extends AddToCartState {
  final List<Topping> toppings;
  final String iceType;
  final String sugarType;
  final String variantType;
  final String sizeType;
  const AddToCartDisplaySuccess({
    required this.iceType,
    required this.sugarType,
    required this.variantType,
    required this.sizeType,
    required this.toppings,
  });
}

final class AddItemToCartFailure extends AddToCartState {
  final ServerError error;

  const AddItemToCartFailure({required this.error});
}
