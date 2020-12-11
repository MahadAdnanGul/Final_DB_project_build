import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/menuMangementPage_ViewUpdate.dart';
import 'package:frontend/Pages/menuMangementPage_addItems.dart';



class MenuMangementPage  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('McScience Menu Management', style: TextStyle(color: Colors.yellowAccent),
      ),
      backgroundColor: Colors.redAccent,
    ),
    body: Column(children: [
      Container(
        child: raisedButton("Add items",onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>MenuManagement_addItems()))
      ),
      ),
      Container(
        child: raisedButton("View and update items",onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewUpdateMenuItemPage()))
          ),)
    ],
    ),
    );
}
}