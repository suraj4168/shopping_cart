import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import '../../models/responses/shopping_response.dart';

import '../../database_service/database_service.dart';
import '../../models/api_gateways/api_service.dart';
import '../../models/respositorys/shopping_repository.dart';
import 'shopping_events.dart';
import 'shopping_states.dart';

class ShoppingBloc extends Bloc<AuthEvent, ShoppingState> {
  final authRepository = Injector.appInstance.get<AuthRepository>();

  ShoppingBloc() : super(LoadingProduct());

  @override
  Stream<ShoppingState> mapEventToState(AuthEvent event) async* {
    if (event is ShoppingEvent) {
      try {
        yield LoadingProduct();
        final response = await authRepository.getShoppingList();
        if (response.status.toString() == "200") {
          yield DisplayShoppingItems(shoppingData: response.data!);
        } else {
          yield const DisplayShoppingItems(shoppingData: []);
        }
      } catch (e) {
        yield const DisplayShoppingItems(shoppingData: []);
      }
    }

    if (event is AddItemEvent) {
      try {
        String result = await DatabaseService.instance.create(
          ShoppingData(
            id: event.shoppingData.id,
            slug: event.shoppingData.slug,
            title: event.shoppingData.title,
            description: event.shoppingData.description,
            price: event.shoppingData.price,
            featuredImage: event.shoppingData.featuredImage,
            status: event.shoppingData.status,
            createdAt: event.shoppingData.createdAt,
          ),
        );
      } catch (e) {
         print("Error:$e");
      }
    }
  }
}
