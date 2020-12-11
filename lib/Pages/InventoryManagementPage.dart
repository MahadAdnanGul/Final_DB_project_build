import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/InventoryManagementPage_ViewUpdate.dart';
import 'package:frontend/Pages/menuMangementPage_addItems.dart';



class InventoryMangementPage  extends StatelessWidget {

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
          child: raisedButton("View and update inventory",onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewUpdateInventoryPage()))
          ),)
      ],
      ),
    );
  }
}