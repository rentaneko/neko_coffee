part of 'add_to_cart_bloc.dart';

@immutable
sealed class AddToCartState {
  const AddToCartState();
}

final class AddToCartInitialState extends AddToCartState {}

final class AddToCartLoadingState extends AddToCartState {}

final class AddToCartFailureState extends AddToCartState {
  final ServerError error;

  const AddToCartFailureState({required this.error});
}

final class AddToCartDisplaySuccessState extends AddToCartState {
  final String iceType;
  final String sugarType;
  final String variantType;
  final String sizeCup;
  final List<Topping> toppings;
  const AddToCartDisplaySuccessState({
    required this.iceType,
    required this.sugarType,
    required this.variantType,
    required this.sizeCup,
    required this.toppings,
  });
}

final class AddItemToCartFailureState extends AddToCartState {
  final ServerError error;

  const AddItemToCartFailureState({required this.error});
}

final class AddToCartSuccessState extends AddToCartState {}
