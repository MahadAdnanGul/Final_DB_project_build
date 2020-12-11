import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ViewOnly extends StatefulWidget {
  int final_index;
  ViewOnly({this.final_index});
  @override
  _ViewOnlyState createState() => _ViewOnlyState();
}

class _ViewOnlyState extends State<ViewOnly> {

  List<MenuGet> _menugets = List<MenuGet>();
  List<Customer> users = [];
  MenuGet menu;
  Http http = new Http();
  List<String> arr=[];
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  deleteonPressed(BuildContext context,int id, int index) {
    http.MenuDeleteRequest(_menugets[index]);
    setState(() {
      http.getMenu().then((value) {
        setState(() {
          _menugets.clear();
          _menugets.addAll(value);
        });
      });
    });

  }
  UpdateonPressed(BuildContext context,int item_id, int index) {

    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) => MenuManagement_UpdateItems(
          menu: _menugets[index],
        )))
        .then((menu) {
      if (menu != null) {
        http.menuPutRequest(menu);
        setState(() {
          http.getMenu().then((value) {
            setState(() {
              _menugets.clear();
              _menugets.addAll(value);
            });
          });
        });
      }
    });

  }

  Addtocart(MenuGet m,int customer_id){
    print(m.item_name);
    print(m.item_price);
    print(customer_id);
    cartItem_post cart_item = new cartItem_post(m.item_price,customer_id,m.item_name,1,"h","NP");
    http.ShoppingCartPostRequest(cart_item);

    // create a object of class cart_item which holds id,item name, quanity set to 1
    // ,price, hash set to 'n',and status set to NP
    // we will then invoke the http function and send this to the sql table
  }

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
    if (users.isEmpty) {
      setState(() {
        users = Provider.of<List<Customer>>(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView.builder(
          itemCount: _menugets.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: leadingBackgroundColor,
                child: Text(' ${_menugets[index].item_id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
              ),
              onExpansionChanged: (boo) => onExpansionChanged(boo),
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('${_menugets[index].item_name}'),
                    Text('\$ ${_menugets[index].item_price}')]),
              // Text('${_menugets[index].item_name}'
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[


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

