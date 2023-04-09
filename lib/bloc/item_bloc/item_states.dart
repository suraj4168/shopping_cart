
import 'package:equatable/equatable.dart';
import '../../models/responses/shopping_response.dart';

abstract class ProductCartState extends Equatable {
  const ProductCartState();
}


class DisplayCart extends ProductCartState {
  final List<ShoppingData> shoppingData;
  final int total;


  const DisplayCart({required this.shoppingData,required this.total});
  @override
  List<Object> get props => [shoppingData];
}


class LoadingCartProduct extends ProductCartState {
  @override
  List<Object> get props => [];
}

