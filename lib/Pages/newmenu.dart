import 'package:flutter/material.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';

class MenuManagement_UpdateItems extends StatefulWidget {
  MenuGet menu;
  MenuManagement_UpdateItems({this.menu});
  @override
  State<StatefulWidget> createState() {
    return MenuManagement_UpdateItemsState();
  }
}

class MenuManagement_UpdateItemsState extends State<MenuManagement_UpdateItems> {
  String _name;
  String _price;
  
  Http http = new Http();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Item Name'),
      initialValue:  widget.menu.item_name,
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
      initialValue: ' ${widget.menu.item_price}',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Menu items")),
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
                  MenuGet m = new MenuGet(widget.menu.item_id,int.parse(_price),_name);
                  print(m);
                  Navigator.of(context).pop(m);
                  // http.MenuPostRequest(m);

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
