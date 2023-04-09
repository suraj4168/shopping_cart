
import 'package:injector/injector.dart';

import 'models/api_gateways/api_gateway.dart';
import 'models/api_gateways/api_service.dart';
import 'models/respositorys/shopping_repository.dart';


void setupDependencyInjections() async {
  Injector injector = Injector.appInstance;
  injector.registerSingleton<ApiService>(() => ApiService());

  _authRepositoryDI(injector);
  _apiGatewayDi(injector);

}

void _authRepositoryDI(Injector injector) {
  injector.registerDependency<AuthRepository>(() {
    var apiService = injector.get<ApiGateway>();
    return AuthRepository(apiGateway: apiService);
  });
}

void _apiGatewayDi(Injector injector) {
  injector.registerDependency<ApiGateway>(() {
    var apiService = injector.get<ApiService>();
    return ApiGateway(apiService);
  });
}