import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import '../../models/responses/shopping_response.dart';
import '../../database_service/database_service.dart';
import '../../models/respositorys/shopping_repository.dart';
import 'item_events.dart';
import 'item_states.dart';

class ItemBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final authRepository = Injector.appInstance.get<AuthRepository>();

  ItemBloc() : super(LoadingCartProduct());

  @override
  Future<void> close() async {
    //cancel streams
    super.close();
  }

  @override
  Stream<ProductCartState> mapEventToState(ProductCartEvent event) async* {
    if (event is CartEvent) {
      yield LoadingCartProduct();
      try {
        List<ShoppingData> shoppingData =
            await DatabaseService.instance.readAllTodos();
        int? result = await DatabaseService.instance.calculate();
        yield DisplayCart(shoppingData: shoppingData, total: result!);
      } catch (e) {
        yield const DisplayCart(shoppingData: [], total: 0);
      }
    }

    if (event is DeleteCartEvent) {
      await DatabaseService.instance.delete(id: event.id);
      add(CartEvent());
    }
  }
}
