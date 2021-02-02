import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/cart.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class CartPage extends StatelessWidget {
  static String routeName = '/Cart_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: AppTheme.colors.primary,
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => CartItemTile(value.items[index]),
        ),
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final Product product;

  const CartItemTile(
    this.product,
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
                  'Item ${product.name}',
                  key: Key('Cart_text_${product.name}'),
                ),
                trailing: IconButton(
                  key: Key('remove_icon_$product'),
                  icon: Icon(
                    Icons.remove_shopping_cart,
                    color: Colors.red[800],
                  ),
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false)
                        .remove(product);
                    Scaffold.of(context).showSnackBar(
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
