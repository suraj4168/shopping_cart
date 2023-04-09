import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/item_bloc/item_bloc.dart';
import 'package:shopping/pages/shopping_items.dart';
import 'bloc/shopping_bloc/shopping_bloc.dart';
import 'di.dart';
import 'util/color_const.dart';

void main() {
  setupDependencyInjections();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,

  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShoppingBloc>(create: (context) => ShoppingBloc()),
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()),
      ],
      child: MaterialApp(
        title: "Shopping Cart",
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConst.white,
          backgroundColor: ColorConst.white,
          primaryColor: ColorConst.primaryColorMaterial,
          primarySwatch: ColorConst.primaryColorMaterial,
          primaryColorDark: ColorConst.primaryColorMaterial,
        ),
        debugShowCheckedModeBanner: false,
        home: const ShoppingItems(),
      ),
    );
  }
}

