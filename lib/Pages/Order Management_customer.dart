import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/orders.dart';

class OrderManagementPageCustomer extends StatefulWidget {
  int final_index;
  OrderManagementPageCustomer({this.final_index});

  @override
  _OrderManagementPageCustomerState createState() => _OrderManagementPageCustomerState();
}

class _OrderManagementPageCustomerState extends State<OrderManagementPageCustomer> {

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
        print("final_index: "+widget.final_index.toString());
        for(int i=0;i<_menugets.length;i++)
          {
            print("order_customer: "+_menugets[i].customer_id.toString());
            if(_menugets[i].customer_id!=widget.final_index)
              {
                _menugets.removeAt(i);
                i=i-1;
              }
          }
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
              leading: Text("Order ID: "+_menugets[index].order_id.toString(),
               style: TextStyle(fontSize: 20),
               // radius: 20.0,
               // backgroundColor: leadingBackgroundColor,
               // child: Text(' ${_menugets[index].order_id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
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

                      // onPressed: ()=>UpdateonPressed(context, _menugets[index].item_id,index),


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

