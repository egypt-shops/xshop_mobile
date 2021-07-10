import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_search.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.primary,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: AppTheme.colors.secondry,
            ),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          title: Text(
            'Shops',
            style: TextStyle(
              color: AppTheme.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: AppTheme.colors.secondry,
                ),
                tooltip: 'search',
                onPressed: null)
          ],
        ),
        body: ShopApi(),
      ),
    );
  }
}

//
class ShopList extends StatelessWidget {
  final List<Shop> shops;

  ShopList({Key key, this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<FavoritesShops>(context);
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShopDetails(shops[index].id,
                    shops[index].name, shops[index].subdomain)),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 2.5, 5, 2.5),
          height: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0, 0.0, 0.0),
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/try.jpg'),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(
                            color: Colors.teal[900],
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${shops[index].name}',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: AppTheme.colors.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'the shop is fantastic , ',
                              style: TextStyle(fontSize: 12),
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          icon: favoritesList.items
                                  .where((element) =>
                                      element.name == (shops[index].name))
                                  .isNotEmpty
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red[600],
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                ),
                          onPressed: () {
                            favoritesList.items
                                    .where((element) =>
                                        element.name == (shops[index].name))
                                    .isEmpty
                                ? favoritesList.add(shops[index])
                                : favoritesList.remove(shops[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(favoritesList.items
                                        .where((element) =>
                                            element.name == (shops[index].name))
                                        .isNotEmpty
                                    ? 'Added to favorites.'
                                    : 'Removed from favorites.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, childCount: shops.length));
  }
}
