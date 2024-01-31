import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class LoadHomeEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  @override
  Stream<HomeState> applyAsync({HomeState? currentState, HomeBloc? bloc}) {
    // TODO: implement applyAsync
    throw UnimplementedError();
  }
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  @override
  Stream<HomeState> applyAsync({HomeState? currentState, HomeBloc? bloc}) {
    // TODO: implement applyAsync
    throw UnimplementedError();
  }
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {
  @override
  Stream<HomeState> applyAsync({HomeState? currentState, HomeBloc? bloc}) {
    // TODO: implement applyAsync
    throw UnimplementedError();
  }
}

class HomeCartButtonNavigateEvent extends HomeEvent {
  @override
  Stream<HomeState> applyAsync({HomeState? currentState, HomeBloc? bloc}) {
    // TODO: implement applyAsync
    throw UnimplementedError();
  }
}
