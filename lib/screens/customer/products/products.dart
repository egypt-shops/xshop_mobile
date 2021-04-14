import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/products/cart.dart';
import 'package:xshop_mobile/screens/customer/products/product_search.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:xshop_mobile/screens/customer/products/product_details.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/product.dart';

List<Product> products = [];

class Products extends StatefulWidget {
  final String shopId;

  Products({Key products, this.shopId}) : super(key: products);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          iconTheme: IconThemeData(
            color:
                Theme.of(context).secondaryHeaderColor, //change your color here
          ),
          title: Text(
            "Products",
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              tooltip: 'Search',
              onPressed: () {
                showSearch(context: context, delegate: ProductSearch(products));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              tooltip: 'Cart',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
            )
          ]),
      ProductApi(
        id: widget.shopId,
      )
    ])));
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var cartList = Provider.of<CartModel>(context);
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.6),
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetProduct(products[index].id),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                  padding: EdgeInsets.all(3),
                  child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image(
                                            image: NetworkImage(
                                                'https://picsum.photos/300?image=${products[index].id.toString()}')))),
                                Expanded(
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${products[index].name}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2),
                                                    Text(
                                                        '${products[index].price} EGP',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                            color: Theme.of(
                                                                    context)
                                                                .backgroundColor))
                                                  ]),
                                              Icon(
                                                Icons.favorite_border,
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              )
                                            ])))
                              ])))));
        }, childCount: products.length));
  }
}
