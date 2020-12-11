import 'package:flutter/material.dart';
import 'package:frontend/Pages/newuser.dart';
import 'package:frontend/models/cashier.dart';
import 'BO/BO.dart';
import 'Pages/homepage.dart';
import 'Pages/login.dart';
import 'models/user.dart';
import 'dart:async';
import 'dart:convert';
import 'models/http.dart';
import 'package:provider/provider.dart';
import 'package:frontend/Pages/Start.dart';

// Clase Http
// Funcion status (200 etc con switch case) -> OK
// Update and delete Server -> OK
// Codificar contraseña -> OK

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Http http = new Http();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.fromFuture(http.getUsers()),
      builder: (context, response) {
        if(!response.hasData){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator()
              ],
            )
          );
        } else if(response.hasError) {
          return Center(child: Text(response.error));
        } else {
          return MultiProvider(
            providers: [
              Provider<List<Customer>>.value(value: response.data),
              //Provider<List<Cashier>>.value(value: response.data)
            ],
            child: MaterialApp(
              title: 'Flutter Rest Api',
              theme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.orange,
                accentColor: Colors.orange,
              ),
              home: StartPage(),
            ),
          );
        }
      }
    );
  }
}

