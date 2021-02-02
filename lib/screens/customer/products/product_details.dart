import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:xshop_mobile/models/cart.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var cartList;
  @override
  Widget build(BuildContext context) {
    setState(() {
      cartList = Provider.of<CartModel>(context);
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.primary,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: AppTheme.colors.primaryLight,
                padding: EdgeInsets.all(5.00),
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _imageloader(9),
                    _imageloader(7),
                    _imageloader(5),
                    _imageloader(3),
                  ],
                ),
              ),
              Container(
                color: AppTheme.colors.primaryLight,
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.product.price} EGP',
                          style:
                              TextStyle(fontSize: 18, color: Colors.red[900])),
                      Container(
                          padding: EdgeInsets.all(5.00),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star, color: Colors.grey),
                              Icon(Icons.star, color: Colors.grey),
                            ],
                          )),
                    ]),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Text('${widget.product.name}',
                      style: TextStyle(fontSize: 25, color: Colors.black))),
              Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  height: 250,
                  child: SingleChildScrollView(
                      child: Text(
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height"
                          "Long text here which is longer than the container height",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey[700])))),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    SizedBox(),
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: ButtonTheme(
                            height: 80.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: cartList.items.contains(widget.product)
                                  ? Colors.red[700]
                                  : Colors.green,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  cartList.items.contains(widget.product)
                                      ? cartList.items.remove(widget.product)
                                      : cartList.items.add(widget.product);
                                  /*Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(cartList.items.contains(product)
                                      ? 'Added to favorites.'
                                      : 'Removed from favorites.'),
                                  duration: Duration(seconds: 1),
                                ));*/
                                });
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: cartList.items
                                          .contains(widget.product)
                                      ? [
                                          Text("remove from Cart".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 25,
                                              )),
                                          Icon(
                                            Icons.remove_shopping_cart,
                                            color: Colors.white,
                                            size: 40,
                                          )
                                        ]
                                      : [
                                          Text("Add to Cart".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 25,
                                              )),
                                          Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.white,
                                            size: 40,
                                          )
                                        ]),
                            )))
                  ]))
            ]));
  }
}

Widget _imageloader(id) => Stack(children: <Widget>[
      SizedBox(
          height: 300,
          width: 300,
          child: Center(child: CircularProgressIndicator())),
      Center(
        child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: 'https://picsum.photos/300?image=$id'),
      )
    ]);
