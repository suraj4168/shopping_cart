
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:shopping/models/api_gateways/api_constant.dart';
import '../api_gateways/api_gateway.dart';
import '../responses/shopping_response.dart';

class AuthRepository {
  AuthRepository({@required this.apiGateway});

  final ApiGateway? apiGateway;


  Future<ShoppingItemResponse> getShoppingList() async {
    final result = await apiGateway?.getCall(
        endPoint:ApiConstants.shoppingUrl);
    if (result!.success) {
      try
      {
        ShoppingItemResponse response = ShoppingItemResponse.fromJson(json.decode(result.body));
        return response;
      }
      catch(e)
    {
      print(e.toString());
    }

    }
    return ShoppingItemResponse();
  }
}
