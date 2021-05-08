import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/cart.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/services/cart.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class CartPage extends StatelessWidget {
  static String routeName = '/Cart_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
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
                        itemBuilder: (context, index) =>
                            CartItemTile(cart[index]),
                      );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class CartItemTile extends StatelessWidget {
  final Cart cartItem;

  const CartItemTile(
    this.cartItem,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            color: AppTheme.colors.primaryLight,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.colors.secondryLight,
                ),
                title: Text(
                  'Item ${cartItem.product.name}',
                  key: Key('Cart_text_${cartItem.product.name}'),
                ),
                trailing: IconButton(
                  key: Key('remove_icon_${cartItem.product}'),
                  icon: Icon(
                    Icons.remove_shopping_cart,
                    color: Colors.red[800],
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed from Cart.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            )));
  }
}
