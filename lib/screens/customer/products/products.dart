import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/products/cart.dart';
import 'package:xshop_mobile/screens/customer/products/product_search.dart';
import 'package:xshop_mobile/screens/data_entry/edit_product.dart';
import 'package:xshop_mobile/screens/home/home.dart';
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
            backgroundColor: Theme.of(context).primaryColor,
            body: ProductApi(
              id: widget.shopId,
            )));
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var cartList = Provider.of<CartModel>(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.6),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetProduct(products[index]),
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
                                              usertype == 'Data Entry Clerk'
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditProduct(
                                                                    product:
                                                                        products[
                                                                            index]),
                                                            fullscreenDialog:
                                                                true,
                                                          ),
                                                        );
                                                      })
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.favorite_border,
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                      ),
                                                      onPressed: () {},
                                                    )
                                            ])))
                              ])))));
        },
        itemCount: products.length);
  }
}
