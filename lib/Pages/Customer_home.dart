import 'package:flutter/material.dart';
import 'package:frontend/Pages/InventoryManagementPage.dart';
import 'package:frontend/Pages/Order%20Management_customer.dart';
import 'package:frontend/Pages/User_profile.dart';
import 'package:frontend/Pages/ViewMenu.dart';
import 'package:frontend/Pages/homepage.dart';
import 'package:frontend/Pages/ShoppingCartPage.dart';
import 'package:frontend/Pages/login.dart';
import 'package:frontend/Pages/menuMangementPage.dart';
import 'package:frontend/Pages/menuMangementPage_ViewUpdate.dart';
import 'package:frontend/Pages/newuser.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/BO/BO.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart';

class CustomerPage extends StatefulWidget {
  int final_index;
  CustomerPage({this.final_index});
  _CustomerPageState createState() => _CustomerPageState();

}

class _CustomerPageState extends State<CustomerPage> {
  List<Customer> users = [];
  Http http = new Http();
  //int index;
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  @override
  initState() {
    super.initState();
  }












  @override
  Widget build(BuildContext context) {
    int customer_id=widget.final_index;
    if (users.isEmpty) {
      setState(() {
        users = Provider.of<List<Customer>>(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('McCustomer', style: TextStyle(color: Colors.yellowAccent),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
              child: raisedButton("Account",onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(final_index: widget.final_index,))))
          ),
          Container(
              child: raisedButton("Menu",
                  onPressed: () => {print(customer_id),
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewMenuItemPage(final_index: customer_id)))
                  })

          ),
          Container(
              child: raisedButton("Shopping Cart",
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShoppingCartPage(final_index: users[widget.final_index].customer_id)))
                  })

          ),
          Container(
              child: raisedButton("View orders",
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderManagementPageCustomer(final_index: users[widget.final_index].customer_id)))
                  })

          ),

          //  Container(
          //     child: raisedButton("View and update Menu",
          //     onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => ViewUpdateMenuItemPage()))
          //     )

          // ),
        ],
      ),
      // body: Center(
      // child: Padding(
      //  padding: const EdgeInsets.all(8.0), child: _buildList(context))),

    );
  }
}
