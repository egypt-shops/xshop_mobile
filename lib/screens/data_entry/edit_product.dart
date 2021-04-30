import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct({this.product});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _namecontroller = TextEditingController();
  final _pricecontroller = TextEditingController();
  final _stockcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller.text = widget.product.name;
    _pricecontroller.text = widget.product.price;
    _stockcontroller.text = widget.product.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).secondaryHeaderColor),
          title: Text(
            'Edit product',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  setState(() {
                    _saving = true;
                  });
                  http.Response response = await updateProduct(
                      widget.product.id.toString(),
                      _namecontroller.text,
                      _pricecontroller.text,
                      int.parse(_stockcontroller.text),
                      2);
                  if (response != null) {
                    setState(() {
                      _saving = false;
                    });
                    /*if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('updated successfully')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('err: ' + response.statusCode.toString())));
                    }*/
                    Navigator.pop(context);
                  }
                  setState(() {
                    _saving = false;
                  });
                })
          ],
        ),
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Expanded(
                      child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: _namecontroller,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.label),
                                    hintText: 'product name',
                                    labelText: 'edit Name',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'patient name couldnt be empty';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _pricecontroller,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.attach_money),
                                    hintText: 'product price',
                                    labelText: 'edit price',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'product price couldnt be empty';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _stockcontroller,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.list),
                                    hintText: 'product quantity',
                                    labelText: 'edit stock',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'product quantity couldnt be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ]))),
                ]))));
  }
}
