import 'package:equatable/equatable.dart';

import '../../models/responses/shopping_response.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class ShoppingEvent extends AuthEvent {
  List<Object?> get props => [];
}

class AddItemEvent extends AuthEvent {
  final ShoppingData shoppingData;
  const AddItemEvent(this.shoppingData);

  @override
  List<Object?> get props => [shoppingData];
}



