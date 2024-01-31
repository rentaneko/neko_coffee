import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  CartState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnCartState extends CartState {

  UnCartState();

  @override
  String toString() => 'UnCartState';
}

/// Initialized
class InCartState extends CartState {
  InCartState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InCartState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorCartState extends CartState {
  ErrorCartState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorCartState';

  @override
  List<Object> get props => [errorMessage];
}
