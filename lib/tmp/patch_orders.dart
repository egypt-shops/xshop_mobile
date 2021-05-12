import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/services/patch_order.dart';

class UpdateOrders extends StatefulWidget {
  int id;
  UpdateOrders({@required this.id});
  @override
  _UpdateOrdersState createState() => _UpdateOrdersState();
}

class _UpdateOrdersState extends State<UpdateOrders> {
  final TextEditingController _idController = TextEditingController();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

  bool paid = false;

  Future<Order> _futureOrders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureOrders == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _userController,
                        decoration: InputDecoration(
                          hintText: 'write user',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _shopController,
                        decoration: InputDecoration(
                          hintText: 'Enter Shop Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CheckboxListTile(
                        title: Text("is paid"),
                        value: paid,
                        onChanged: (value) {
                          setState(() {
                            paid = value;
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureOrders = modifyOrder(
                                widget.id.toString(),
                                _userController.text,
                                _shopController.text,
                                paid);
                          });
                        },
                        child: Text('Edit Data'))
                  ],
                )
              : FutureBuilder<Order>(
                  future: _futureOrders,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Order ID is:  ' + snapshot.data.id.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            'User is:  ' + snapshot.data.user.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            'Shop is:  ' + snapshot.data.shop.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            'isPaid is:  ' + snapshot.data.paid.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //Text(
                          //'Order Number is:  ' +
                          //   snapshot.data.order.toString(),
                          // style:
                          //     TextStyle(fontSize: 25, color: Colors.orange),
                          // )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return CircularProgressIndicator();
                  })),
    );
  }
}
