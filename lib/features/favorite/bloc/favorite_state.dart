import 'package:neko_coffee/models/favourite.model.dart';

abstract class FavouriteState {}

abstract class FavouriteActionState extends FavouriteState {}

class FavouriteInitialState extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final List<FavouriteModel> favourites;
  FavouriteLoadedState({required this.favourites});
}

class FavouriteErrorState extends FavouriteState {
  final String errorMsg;

  FavouriteErrorState({required this.errorMsg});
}

class FavouriteButtonInHomeClickedState extends FavouriteActionState {}

class FavouriteAddToListSuccessState extends FavouriteState {
  final List<FavouriteModel> favourites;

  FavouriteAddToListSuccessState({required this.favourites});
}
