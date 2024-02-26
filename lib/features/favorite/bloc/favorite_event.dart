import 'package:flutter/widgets.dart';

@immutable
abstract class FavouriteEvent {}

class FavouriteInitialEvent extends FavouriteEvent {}

class RemoveItemClickedEvent extends FavouriteEvent {
  final String idProduct;

  RemoveItemClickedEvent({required this.idProduct});
}

class FavouriteButtonInHomeClickedEvent extends FavouriteEvent {
  final String idProduct;

  FavouriteButtonInHomeClickedEvent({required this.idProduct});
}
