import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  WishlistState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnWishlistState extends WishlistState {

  UnWishlistState();

  @override
  String toString() => 'UnWishlistState';
}

/// Initialized
class InWishlistState extends WishlistState {
  InWishlistState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InWishlistState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorWishlistState extends WishlistState {
  ErrorWishlistState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorWishlistState';

  @override
  List<Object> get props => [errorMessage];
}
