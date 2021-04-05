import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/products/cart.dart';
import 'package:xshop_mobile/screens/customer/products/product_search.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:xshop_mobile/screens/customer/products/product_details.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/product.dart';

class Products extends StatefulWidget {
  final String shopId;

  Products({Key key, this.shopId}) : super(key: key);
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
                    onPressed: () {
                      showSearch(context: context, delegate: ProductSearch());
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: AppTheme.colors.secondry,
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
            body: Center(
                child: ProductApi(
              id: widget.shopId.toString(),
            ))));
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
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
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
                                      fontSize: 20,
                                      color: AppTheme.colors.primary)),
                              Text('${products[index].price} EGP',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red[900]))
                            ])))));
      },
    );
  }
}
