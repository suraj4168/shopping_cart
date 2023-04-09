import 'package:equatable/equatable.dart';


abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();
}

class CartEvent extends ProductCartEvent {

  List<Object?> get props => [];

}

class DeleteCartEvent extends ProductCartEvent {
  final int id;
  const DeleteCartEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

