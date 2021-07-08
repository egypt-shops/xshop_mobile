import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';

class FavoritesShopsPage extends StatelessWidget {
  static String routeName = '/favorites_page';

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesShops>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => FavoriteItemTile(value.items[index]),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final Shop item;

  const FavoriteItemTile(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShopDetails(item.id, item.name)),
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
                                '${item.name}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
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
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 25,
                            ),
                            onPressed: () {
                              Provider.of<FavoritesShops>(context,
                                      listen: false)
                                  .remove(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Removed from favorites.'),
                                      duration: Duration(seconds: 1)));
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
