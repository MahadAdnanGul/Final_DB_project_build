import 'package:flutter/material.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/inventory.dart';

class InventoryManagement_UpdateItems extends StatefulWidget {
  InventoryGet menu;
  InventoryManagement_UpdateItems({this.menu});
  @override
  State<StatefulWidget> createState() {
    return InventoryManagement_UpdateItemsState();
  }
}

class InventoryManagement_UpdateItemsState extends State<InventoryManagement_UpdateItems> {
  String _quantity;
  //String _price;

  Http http = new Http();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Quantity'),
      initialValue:  widget.menu.quantity.toString(),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Quantity is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _quantity = value;
      },
    );
  }



  /*Widget _buildPrice() {
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Inventory items")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
             // _buildPrice(),
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
                  print(int.parse(_quantity));
                 // print(_name);
                  InventoryGet m = new InventoryGet(widget.menu.num,int.parse(_quantity),widget.menu.product_name,widget.menu.product_id);
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
