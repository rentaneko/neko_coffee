import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/wishlist/bloc/index.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc(WishlistState initialState) : super(initialState) {}
}
