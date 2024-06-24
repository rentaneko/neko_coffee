part of 'cart_bloc.dart';

@immutable
sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final ServerError error;

  const CartFailure({required this.error});
}

final class CartSuccess extends CartState {}
