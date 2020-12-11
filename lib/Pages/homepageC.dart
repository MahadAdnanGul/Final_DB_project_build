import 'package:flutter/material.dart';
import 'package:frontend/Pages/Newcashier.dart';
import 'package:frontend/models/cashier.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/BO/BO.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart';

class MyHomePageCashier extends StatefulWidget {
  MyHomePageCashier();
  _MyHomePageCashierState createState() => _MyHomePageCashierState();
}

class _MyHomePageCashierState extends State<MyHomePageCashier> {
  List<Cashier> users = [];
 // List<Cashier> displayed= [];
  Http http = new Http();
  //int index;
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  @override
  initState() {
    http.getCashier().then((value) {
      setState(() {
        users.addAll(value);
      });
    });
    super.initState();
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
  updateonPressed(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) => Newcashier(
          user: users[index],
        )))
        .then((user) {
      if (user != null) {
        http.makeUserPutRequest(user);
        setState(() {
          users.removeAt(index);
          users.add(user);
        });
      }
    });
  }

  alertonPressed(int index) {
    http.makeCashierDeleteRequest(users[index]);
    setState(() {
      users.removeAt(index);
    });
    Navigator.of(context).pop();
  }

  deleteonPressed(BuildContext context, int index) {
    openActionDialog(
        context,
        'Alert',
        'Are you sure want to delete ${users[index].name} ?',
        'Delete',
            () => alertonPressed(index));
  }

  floatingonPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Newcashier()))
        .then((user) {
      if (!isDefaultC(user as Cashier)) {
        // New user
        if (user.id == -1) {
          user = asignidC(users, user as Cashier);
          http.makeCashierPostRequest(user);
          setState(() {
            users.add(user);
          });
        } else {
          // Update user
          http.makeUserPutRequest(user);
          int index = users.indexWhere((item) => item.id == user.id);
          users.removeAt(index);
          users.insert(index, user);
        }
      }
    });
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          users.sort((a, b) => a.id.compareTo(b.id));
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: leadingBackgroundColor,
              child: Text('${users[index].id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
            ),
            onExpansionChanged: (boo) => onExpansionChanged(boo),
            title: Text('${users[index].name}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    raisedButton('Update',
                        onPressed: () => updateonPressed(index),
                        fontSize: 15.0),
                    raisedButton('Delete',
                        onPressed: () => deleteonPressed(context, index),
                        fontSize: 15.0),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('McCashiers'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: _buildList(context))),
      floatingActionButton: FloatingActionButton(
        onPressed: floatingonPressed,
        child: Icon(Icons.add),
      ),
    );
  }
}
