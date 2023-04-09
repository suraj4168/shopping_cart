

import 'package:equatable/equatable.dart';

import '../../models/responses/shopping_response.dart';


abstract class ShoppingState extends Equatable {
  const ShoppingState();
}

class LoadingProduct extends ShoppingState {
  @override
  List<Object> get props => [];
}

class DisplayShoppingItems extends ShoppingState {
  final List<ShoppingData> shoppingData;
  const DisplayShoppingItems( {required this.shoppingData});
  @override
  List<Object> get props => [shoppingData];
}










