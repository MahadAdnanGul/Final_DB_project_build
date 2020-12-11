import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/orders.dart';

import '../models/sales.dart';

class OrderManagementPage extends StatefulWidget {

  @override
  _OrderManagementPageState createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {

  List<orders_get> _menugets = List<orders_get>();
  MenuGet menu;
  Http http = new Http();
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  /*deleteonPressed(BuildContext context,int id, int index) {
    http.MenuDeleteRequest(_menugets[index]);
    setState(() {
      http.getMenu().then((value) {
        setState(() {
          _menugets.clear();
          _menugets.addAll(value);
        });
      });
    });

  }*/
  UpdateonPressed(BuildContext context,int order_id, int index) {


        http.OrderPutRequest(_menugets[index]);
        setState(() {
          http.OrderGet().then((value) {
            setState(() {
              _menugets.clear();
              _menugets.addAll(value);
            });
          });
        });
        if(_menugets[index].order_status=="complete")
          {
            sales_post s=new sales_post(_menugets[index].order_id,_menugets[index].time,_menugets[index].day,_menugets[index].month,_menugets[index].year,_menugets[index].order_total);
            http.salesPostrequest(s);

          }



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
        leadingNumberColor = Colors.black;
      });
    }
  }



  @override
  void initState() {
    http.OrderGet().then((value) {
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
        title: Text('McOrder Management'),
      ),
      body: ListView.builder(
          itemCount: _menugets.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: leadingBackgroundColor,
                child: Text(' ${_menugets[index].order_id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
              ),
              onExpansionChanged: (boo) => onExpansionChanged(boo),
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Status: ${_menugets[index].order_status}'),
                    Text('Total: ${_menugets[index].order_total}')
                    ]),
              // Text('${_menugets[index].item_name}'
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DropdownButton(
                        hint: Text("Update Order Status"),
                         value: _menugets[index].order_status,
                         onChanged: (String newValue){
                          setState(() {
                            _menugets[index].order_status=newValue;
                          });
                         },
                          items: <String>["complete","confirmed","cancelled","inprogress","pending"]
                          .map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      ),
                         // onPressed: ()=>UpdateonPressed(context, _menugets[index].item_id,index),

                      raisedButton('Confirm changes',
                          onPressed: ()=>UpdateonPressed(context, _menugets[index].order_id,index),
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

