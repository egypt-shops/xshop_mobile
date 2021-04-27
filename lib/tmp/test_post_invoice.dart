import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/services/post_invoices.dart';

class Simulate extends StatefulWidget {
  @override
  _SimulateState createState() => _SimulateState();
}

class _SimulateState extends State<Simulate> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _orderController = TextEditingController();

  Future<Invoice> _futureInvoices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureInvoices == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: 'write id',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _userController,
                        decoration: InputDecoration(
                          hintText: 'Enter User Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _orderController,
                        decoration: InputDecoration(
                          hintText: 'write order',
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureInvoices = createInvoices(
                                _userController.text, _orderController.text);
                          });
                        },
                        child: Text('Create Data'))
                  ],
                )
              : FutureBuilder<Invoice>(
                  future: _futureInvoices,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'User is:  ' + snapshot.data.user.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Order Number is:  ' +
                                snapshot.data.order.toString(),
                            style:
                                TextStyle(fontSize: 25, color: Colors.orange),
                          ),
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

/*class Simulate extends StatefulWidget {
  String _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'write the title'),
            ),
          )
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
*/
