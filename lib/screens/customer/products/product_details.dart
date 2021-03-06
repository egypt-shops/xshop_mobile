import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/screens/data_entry/edit_product.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/services/cart.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:xshop_mobile/models/product.dart';

class GetProduct extends StatelessWidget {
  GetProduct(this.product);
  final Product product;
  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<FavoritesProducts>(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // 1

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              usertype == 'Data Entry Clerk'
                  ? IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProduct(
                              product: product,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                      })
                  : IconButton(
                      icon: favoritesList.items
                              .where(
                                  (element) => element.name == (product.name))
                              .isNotEmpty
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red[600],
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).primaryColor,
                            ),
                      onPressed: () {
                        !favoritesList.items
                                .where(
                                    (element) => element.name == (product.name))
                                .isNotEmpty
                            ? favoritesList.add(product)
                            : favoritesList.remove(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(favoritesList.items.contains(product)
                                ? 'Added to favorites.'
                                : 'Removed from favorites.'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      })
            ]),
        body: FutureBuilder<Product>(
            future: fetchProductsID(http.Client(), product.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProductDetails(product: snapshot.data);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Center(
                    child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Center(child: CircularProgressIndicator())));
              }
            }));
  }
}

class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _saving,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: AppTheme.colors.primaryLight,
                padding: EdgeInsets.all(5.00),
                height: 250,
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
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
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
                                  fontSize: 17, color: Colors.grey[700]))))),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: ButtonTheme(
                      height: 70.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () async {
                          setState(() {
                            _saving = true;
                          });
                          var addcart =
                              await postCart(widget.product.id, 1, 'add');
                          if (addcart != null) {
                            setState(() {
                              _saving = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green[300],
                                content: Text(
                                    '${widget.product.name} added to Cart, you can increase the quantity there'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            setState(() {
                              _saving = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'faild to add ${widget.product.name} to the cart'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
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
            ]));
  }
}

Widget _imageloader(id) => Stack(children: <Widget>[
      SizedBox(
          height: 250,
          width: 250,
          child: Center(
              child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(AppTheme.colors.primaryLight),
            backgroundColor: AppTheme.colors.primary,
          ))),
      Center(
        child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: 'https://picsum.photos/300?image=$id'),
      )
    ]);
