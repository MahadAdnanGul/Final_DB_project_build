import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';

import '../models/inventory.dart';

class MenuManagement_addItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuManagement_addItemsState();
  }
}

class MenuManagement_addItemsState extends State<MenuManagement_addItems> {
  List<MenuGet> _menugets = List<MenuGet>();
  String _name;
  String _price;
  Timer _timer;
  Http http = new Http();
  bool check=false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  

  Widget _buildPrice() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int Price = int.tryParse(value);

        if (Price == null || Price <= 0) {
          return 'Price must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _price = value;
      },
    );
  }

  @override
  void initState() {
    http.getMenu().then((value) {
      setState(() {
        _menugets.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Menu items")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildPrice(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  _formKey.currentState.reset();
                  print(int.parse(_price));
                  print(_name);
                  MenuPost m = new MenuPost(int.parse(_price),_name);
                  InventoryPost inv=new InventoryPost(1, _name, _menugets.length+1);
                  print(m);

                  http.MenuPostRequest(m);


                  http.InventoryPostRequest(inv);




                  //Send to API
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
