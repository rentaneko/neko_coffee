import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/favorite/index.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(FavoriteState initialState) : super(initialState) {}
}
