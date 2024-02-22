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
