import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/cashier.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Newcashier extends StatefulWidget {
  Cashier user;
  Newcashier({this.user});
  @override
  _NewcashierState createState() => _NewcashierState();
}

class _NewcashierState extends State<Newcashier> {
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;
  TextEditingController _controller44;

  TextEditingController _controller5;
  bool validate1;
  bool validate2;
  bool validate3;
  bool validate4;
  bool validate44;
  bool validate5;
  double spaceBetweenTextfields;
  double spaceWithButton;
  bool outlineBorder;

  @override
  void initState() {
    if (widget.user == null) widget.user = new Cashier.def();
    _controller1 = TextEditingController();
    _controller1.text = widget.user.name;
    _controller2 = TextEditingController();
    _controller2.text = widget.user.number;
    _controller3 = TextEditingController();
    _controller3.text = widget.user.email;
    _controller4 = TextEditingController();
    _controller4.text = widget.user.address;
    _controller44 = TextEditingController();
    _controller44.text = widget.user.city;

    _controller5 = TextEditingController();
    _controller5.text = widget.user.hashBase64;
    validate1 = true;
    validate2 = true;
    validate3 = true;
    validate4=true;
    validate44=true;
    validate5 = true;
    spaceBetweenTextfields = 10.0;
    spaceWithButton = 30.0;
    outlineBorder = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller44.dispose();
    _controller5.dispose();
    super.dispose();
  }

  onPressed() {
    String name = _controller1.text;
    String number = _controller2.text;
    String email = _controller3.text;
    String address= _controller4.text;
    String city= _controller44.text;
    String password = _controller5.text;
    setState(() {
      isNullOrEmpty(name) ? validate1 = false : validate1 = true;
      validateMobile(number) ? validate2 = false : validate2 = true;
      validateEmail(email) ? validate3 = false : validate3 = true;
      isNullOrEmpty(address) ? validate4 = false : validate4 = true;
      isNullOrEmpty(city) ? validate44 = false : validate44 = true;
      isNullOrEmpty(password) ? validate5 = false : validate5 = true;

    });
    if (validate1 == true &&
        validate2 == true &&
        validate3 == true &&
        validate4 == true &&
        validate44 == true &&
        validate5 == true) {
      setState(() {
        widget.user.name = name;
        widget.user.number = number;
        widget.user.mail = email;
        widget.user.address=address;
        widget.user.city=city;
        widget.user.hash = password;


      });

      Navigator.of(context).pop(widget.user);
    }
  }

  Widget _inputData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          textfield('Name', _controller1,
              obscureText: false,
              validate: validate1,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Number', _controller2,
              obscureText: false,
              validate: validate2,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Email', _controller3,
              obscureText: false,
              validate: validate3,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Address', _controller4,
              obscureText: false,
              validate: validate4,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('City', _controller44,
              obscureText: false,
              validate: validate44,
              outlineBorder: outlineBorder),

          SizedBox(height: spaceBetweenTextfields),
          textfield('Password', _controller5,
              obscureText: true,
              validate: validate5,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceWithButton),
          isDefaultC(widget.user)
              ? raisedButton('Insert', fontSize: 18.0, onPressed: onPressed, height: 50.0)
              : raisedButton('Update', fontSize: 18.0, onPressed: onPressed, height: 50.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isDefaultC(widget.user)
              ? new Text('New cashier')
              : new Text('Update cashier'),
        ),
        body: Center(child: _inputData(context)));
  }
}
