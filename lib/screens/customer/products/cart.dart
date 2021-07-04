import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/cart.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/services/cart.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class CartPage extends StatefulWidget {
  static String routeName = '/Cart_page';
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Cart>>(
            future: getCart(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var cart = snapshot.data;

                return cart.length == 0
                    ? Center(
                        child: Text('Cart is empty'),
                      )
                    : ListView.builder(
                        itemCount: cart.length,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                            child: SizedBox(
                                height: 130,
                                child: Card(
                                    elevation: 3,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Center(
                                                  child: SizedBox(
                                                height: 100,
                                                width: 110,
                                                child: Image.network(
                                                    "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f"),
                                              )),
                                              Expanded(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                      '${cart[index].product.name}'),
                                                  Text(
                                                      '${cart[index].product.price}')
                                                ],
                                              )),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      IconButton(
                                                          icon: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.amber),
                                                          tooltip:
                                                              'decrease quantity by 1',
                                                          onPressed: () async {
                                                            var removecart =
                                                                await postCart(
                                                                    cart[index]
                                                                        .product
                                                                        .id,
                                                                    cart[index]
                                                                            .quantity -
                                                                        1,
                                                                    'patch');
                                                            if (removecart ==
                                                                null) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          'an error happend try again')));
                                                            } else {
                                                              setState(() {});
                                                            }
                                                          }),
                                                      Text(
                                                          "${cart[index].quantity}"),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.add,
                                                          color: Colors.amber,
                                                        ),
                                                        tooltip:
                                                            'increase quantity by 1',
                                                        onPressed: () async {
                                                          var removecart =
                                                              await postCart(
                                                                  cart[index]
                                                                      .product
                                                                      .id,
                                                                  cart[index]
                                                                          .quantity +
                                                                      1,
                                                                  'patch');
                                                          if (removecart ==
                                                              null) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content: Text(
                                                                        'an error happend try again')));
                                                          } else {
                                                            setState(() {});
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  TextButton(
                                                      onPressed: () async {
                                                        var removecart =
                                                            await postCart(
                                                                cart[index]
                                                                    .product
                                                                    .id,
                                                                cart[index]
                                                                    .quantity,
                                                                'remove');
                                                        if (removecart !=
                                                            null) {
                                                          setState(() {});
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  content: Text(
                                                                      'prduct has been removed from cart')));
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                      'an error happend try again')));
                                                        }
                                                      },
                                                      child: Text(
                                                        "Remove",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button,
                                                      ))
                                                ],
                                              )
                                            ]))))),
                      );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
