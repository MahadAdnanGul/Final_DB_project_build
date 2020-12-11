import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/inventory.dart';
import 'package:frontend/Pages/newinventory.dart';
import 'package:frontend/models/menu.dart';

class ViewUpdateInventoryPage extends StatefulWidget {

  @override
  _ViewUpdateInventoryPageState createState() => _ViewUpdateInventoryPageState();
}

class _ViewUpdateInventoryPageState extends State<ViewUpdateInventoryPage> {

  List<InventoryGet> _menugets = List<InventoryGet>();
  Http http = new Http();
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  onExpansionChanged(bool expanded) {
    if (expanded==true){
      setState(() {
        leadingBackgroundColor = Colors.redAccent;
        leadingNumberColor = Colors.white;
      });
    } else {
      setState(() {
        leadingBackgroundColor = Colors.white;
        leadingNumberColor = Colors.yellowAccent;
      });
    }
  }
  UpdateonPressed(BuildContext context,int item_id, int index) {

    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) => InventoryManagement_UpdateItems(
          menu: _menugets[index],
        )))
        .then((menu) {
      if (menu != null) {
        http.InventoryPutRequest(menu);
        setState(() {
          http.getInventory().then((value) {
            setState(() {
              _menugets.clear();
              _menugets.addAll(value);
            });
          });
        });
      }
    });

  }


  @override
  void initState() {
    http.getInventory().then((value) {
      setState(() {
        _menugets.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('McInventory'),
      ),
      body: ListView.builder(
          itemCount: _menugets.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: leadingBackgroundColor,
                child: Text(' ${_menugets[index].num}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
              ),
              onExpansionChanged: (boo) => onExpansionChanged(boo),
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('${_menugets[index].product_name}'),
                    Text('Quantity: ${_menugets[index].quantity}')]),
              // Text('${_menugets[index].item_name}'
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      raisedButton('Update',
                          onPressed: ()=>UpdateonPressed(context, _menugets[index].num,index),
                          fontSize: 15.0),
                      raisedButton('Delete',
                          fontSize: 15.0),
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}