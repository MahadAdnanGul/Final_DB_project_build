import 'package:flutter/material.dart';
import 'package:frontend/Pages/homepage.dart';
import 'package:frontend/Pages/login.dart';
import 'package:frontend/Pages/newuser.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/BO/BO.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';


class ProfilePage extends StatefulWidget {
  int final_index;
  ProfilePage({this.final_index});
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  createAlertDialog(BuildContext context) {
    TextEditingController customController=TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Column(

          children: <Widget>[
            Text("Verify Password "),
            TextField(controller: customController,)
          ],
        ) ,

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Verify'),
            onPressed: (){
              Customer user= users[widget.final_index];
              if(user.passwordVerify(customController.text))
                {
                  updateonPressed(widget.final_index);
                  //Navigator.pop(context);

                }

            },
          )
        ],
      );

    });
  }

  List<Customer> users = [];
  Http http = new Http();
  //int index;
  Color leadingBackgroundColor;
  Color leadingNumberColor;
  @override
  initState() {
    super.initState();
  }
  updateonPressed(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) => Newuser(
          user: users[index],
        )))
        .then((user) {
      if (user != null) {
        http.makeUserPutRequest(user);
       // setState(() {
        //  users.removeAt(index);
        //  users.add(user);
       // });
      }
    });
  }









  /*Widget _buildList(BuildContext context) {
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
  }*/

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      setState(() {
        users = Provider.of<List<Customer>>(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('CUSTOMER ACCOUNT'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           new Text(users[widget.final_index].name),
            SizedBox(height: 10),
            new Text(users[widget.final_index].number),
            SizedBox(height: 10),
            new Text(users[widget.final_index].email),
            SizedBox(height: 10),
            new Text(users[widget.final_index].address),
            SizedBox(height: 10),
            new Text(users[widget.final_index].city),
            SizedBox(height: 10),
            Container(
             child: raisedButton("EDIT",onPressed: () => createAlertDialog(context)),
            ),
          ],
        ),
      ),
      // body: Center(
      // child: Padding(
      //  padding: const EdgeInsets.all(8.0), child: _buildList(context))),

    );
  }
}
