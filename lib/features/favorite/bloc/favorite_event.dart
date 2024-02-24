import 'package:flutter/widgets.dart';

@immutable
abstract class FavouriteEvent {}

class FavouriteInitialEvent extends FavouriteEvent {}

class RemoveItemClickedEvent extends FavouriteEvent {
  final String idProduct;

  RemoveItemClickedEvent({required this.idProduct});
}

class FavoriteSubcribeEvent extends FavouriteEvent {}
