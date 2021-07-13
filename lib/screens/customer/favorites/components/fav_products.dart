import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/products/product_details.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';

class FavoritesProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProducts>(
        builder: (context, value, child) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.6),
            ),
            itemBuilder: (BuildContext context, int index) {
              return FavoriteItemTile(value.items[index], index);
            },
            itemCount: value.items.length));
  }
}

class FavoriteItemTile extends StatelessWidget {
  final Product item;
  final int index;

  const FavoriteItemTile(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetProduct(item),
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
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image(
                                          image: NetworkImage(
                                              'https://picsum.photos/300?image=${index.toString()}')))),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                                  Text('${item.name}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2),
                                                  Text('${item.price} EGP',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor))
                                                ]),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.grey,
                                                  size: 25,
                                                ),
                                                onPressed: () {
                                                  Provider.of<FavoritesProducts>(
                                                          context,
                                                          listen: false)
                                                      .remove(item);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Removed from favorites.'),
                                                          duration: Duration(
                                                              seconds: 1)));
                                                })
                                          ])))
                            ]))))));
  }
}
