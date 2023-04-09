import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/responses/shopping_response.dart';
import '../bloc/item_bloc/item_bloc.dart';
import '../bloc/item_bloc/item_events.dart';
import '../bloc/item_bloc/item_states.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

late ItemBloc _itemBloc;

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("My Cart"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<ItemBloc, ProductCartState>(builder: (context, state) {
        if (state is LoadingCartProduct) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DisplayCart) {
          if (state.shoppingData.isEmpty) {
            return const Center(child: Text("No Data Found"));
          } else {
            List<ShoppingData>? cartList = state.shoppingData;
            int total = cartList!.length;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 130,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                    ),
                                    child: Image.network(
                                      cartList![i].featuredImage.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartList![i].title.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Price",
                                                style:  TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                  cartList![i].price.toString(),
                                                style:  TextStyle(
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {
                                              _itemBloc.add(
                                                DeleteCartEvent(
                                                    id: cartList[i].id!),
                                              );
                                            },
                                            child: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Items : " "$total",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Grand Total : " "${state.total}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        }
        return Container();
      }),
    );
  }
}
