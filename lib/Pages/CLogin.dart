import 'package:flutter/material.dart';
import 'package:frontend/Pages/CASHIER_HOME.dart';
import 'package:frontend/Pages/Customer_home.dart';
import 'package:frontend/Pages/Newcashier.dart';
import 'package:frontend/Pages/homepage.dart';
import 'package:frontend/Pages/newuser.dart';
import 'package:frontend/Pages/User_profile.dart';
import 'package:frontend/models/cashier.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:frontend/BO/BO.dart';

class CLogin extends StatefulWidget {
  // Passwords are "12345678". They are encrypted at database.
  @override
  _CLoginState createState() => _CLoginState();
}

class _CLoginState extends State<CLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  List<Cashier> users=[];
  Http http = new Http();
  int final_index;


  @override
  initState() {
    http.getCashier().then((value) {
      setState(() {
        users.addAll(value);
      });
    });
    super.initState();
  }
  void openDialog(BuildContext context, String dialogContent) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text('Invalid data'),
            content:
            new Text(dialogContent),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Back'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //List<Cashier> users = Provider.of<List<Cashier>>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cashier',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: hidePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            })),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.redAccent,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      child: Text('Login'),
                      onPressed: () {
                        if (users.any(
                                (item) => item.email == emailController.text)) {
                          Cashier user = users.firstWhere(
                                  (item) => item.email == emailController.text);
                          if (user
                              .passwordVerify(passwordController.text)) {
                            final_index=users.indexOf(user);
                            print(final_index);
                            // Login App: openDialog(context, 'You're in! App gets started here with the current user')
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CashierPage()));
                          } else {
                            openDialog(context, 'Invalid password');
                          }
                        } else {
                          openDialog(context, 'Make sure your username and password are correct');
                        }
                        print(emailController.text);
                        print(passwordController.text);
                      },
                    )), // kldj-34gb-gj89-45gd
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.orange,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                builder: (context) => Newcashier()))
                                .then((user) {
                              /*int id = users[users.length - 1].id + 1;
                          http.makeUserPostRequest(user);
                          user.id = id;
                          setState(() {
                            users.add(user);
                          });*/
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
                                  http.makeCashierPutRequest(user);
                                  int index = users.indexWhere((item) => item.id == user.id);
                                  users.removeAt(index);
                                  users.insert(index, user);
                                }
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CashierPage()));
                            });

                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}
