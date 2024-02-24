import 'package:flutter/material.dart';
import 'package:neko_coffee/models/category.model.dart';

@immutable
abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class HomeMenuClickedEvent extends HomeEvent {
  final String idCate;
  final List<CategoryModel> cates;

  HomeMenuClickedEvent(this.cates, {required this.idCate});
}

class AddToCartClickedHomeEvent extends HomeEvent {
  final String idProduct;
  final int quantity;

  AddToCartClickedHomeEvent({required this.idProduct, required this.quantity});
}

class HomeCartButtonClickedEvent extends HomeEvent {}

class FavouriteButtonClickedEvent extends HomeEvent {
  final String idProduct;

  FavouriteButtonClickedEvent({required this.idProduct});
}
