import 'package:bloc/bloc.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {}
}
