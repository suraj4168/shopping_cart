import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/item_bloc/item_bloc.dart';
import '../../models/responses/shopping_response.dart';
import 'package:shopping/pages/shopping_cart.dart';
import '../bloc/item_bloc/item_events.dart';
import '../bloc/shopping_bloc/shopping_bloc.dart';
import '../bloc/shopping_bloc/shopping_events.dart';
import '../bloc/shopping_bloc/shopping_states.dart';

class ShoppingItems extends StatefulWidget {
  const ShoppingItems({Key? key}) : super(key: key);

  @override
  State<ShoppingItems> createState() => _ShoppingItemsState();
}

class _ShoppingItemsState extends State<ShoppingItems> {
  late ShoppingBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<ShoppingBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Shopping Mall"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
            onPressed: () {
              context.read<ItemBloc>().add(CartEvent());
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ShoppingCart()));
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ShoppingBloc()..add(ShoppingEvent()),
        child:  BlocBuilder<ShoppingBloc, ShoppingState>(
            builder: (context, state) {
              if (state is LoadingProduct) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DisplayShoppingItems) {
                if (state.shoppingData.isEmpty) {
                  return const Center(child: Text("No Data Added"));
                } else {
                  List<ShoppingData>? productList = state.shoppingData;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1.3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: productList!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: () => print("ciao"),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                // add this
                                children: <Widget>[
                                  Expanded(
                                    flex: 8,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                      child: Image.network(
                                          productList[index].featuredImage.toString(),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  productList[index].title.toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            ),
                                            GestureDetector(
                                                onTap: (){
                                                  _authBloc.add(
                                                    AddItemEvent(
                                                      ShoppingData(
                                                          id: productList[index].id,
                                                          description:  productList[index].description,
                                                          title:  productList[index].title,
                                                          createdAt:  productList[index].createdAt,
                                                          featuredImage:  productList[index].featuredImage,
                                                          price: productList[index].price,
                                                          slug: productList[index].slug,
                                                          status:  productList[index].status
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Icon(Icons.shopping_bag_outlined))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }

              return Container();
            }),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
