import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: AppTheme.colors.primary,
                iconTheme: IconThemeData(color: AppTheme.colors.secondry),
                title: Text(
                  "Products",
                  style: TextStyle(color: AppTheme.colors.textPrimary),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: AppTheme.colors.secondry,
                    ),
                    tooltip: 'Search',
                    onPressed: null,
                  ),
                ]),
            body: Center(
              child: FutureBuilder<List<Product>>(
                future: fetchProducts(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? ProductsList(products: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )));
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => FullScreenDialog(
                  product: products[index],
                ),
                fullscreenDialog: true,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(2),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              color: AppTheme.colors.primaryLight,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                          color: AppTheme.colors.secondry, width: 3)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${products[index].name}',
                            style: TextStyle(
                                fontSize: 20, color: AppTheme.colors.primary)),
                        Text('${products[index].price} EGP',
                            style:
                                TextStyle(fontSize: 12, color: Colors.red[900]))
                      ])),
            ),
          ),
        );
      },
    );
  }
}

class FullScreenDialog extends StatelessWidget {
  final Product product;

  FullScreenDialog({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      Text('${product.price} EGP',
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
                  child: Text('${product.name}',
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
                                  side: BorderSide(color: Colors.green)),
                              color: Colors.green,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {},
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
