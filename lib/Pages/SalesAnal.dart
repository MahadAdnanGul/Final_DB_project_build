import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/AnalPage.dart';
import 'package:frontend/Pages/DailyAnalPage.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/models/sales.dart';

class SalesAnalyticsPage extends StatefulWidget {

  @override
  _SalesAnalyticsPageState createState() => _SalesAnalyticsPageState();
}

class _SalesAnalyticsPageState extends State<SalesAnalyticsPage> {

  List<sales_get> _menugets = List<sales_get>();
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
 /* UpdateonPressed(BuildContext context,int order_id, int index) {


    http.OrderPutRequest(_menugets[index]);
    setState(() {
      http.OrderGet().then((value) {
        setState(() {
          _menugets.clear();
          _menugets.addAll(value);
        });
      });
    });



  }*/

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
    http.SalesGet().then((value) {
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
        title: Text('McSales'),
      ),
      body: ListView.builder(
          itemCount: _menugets.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: leadingBackgroundColor,
                child: Text(' ${_menugets[index].sale_id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
              ),
              onExpansionChanged: (boo) => onExpansionChanged(boo),
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('OrderID: ${_menugets[index].order_id}'),
                    Text(_menugets[index].month.toString()+'/'+_menugets[index].day.toString()+'/'+_menugets[index].year.toString()+' '+_menugets[index].time.toString()),
                  ]),
              // Text('${_menugets[index].item_name}'
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Total: "+_menugets[index].order_total.toString())

                      // onPressed: ()=>UpdateonPressed(context, _menugets[index].item_id,index),


                    ],
                  ),
                ),
              ],
            );
          }
      ),
      bottomSheet: Row(
        children: <Widget>[
              raisedButton("View Monthly Analytics",onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AnalPage()))),
              raisedButton("View Daily Analytics",onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DailyAnalPage()))),
        ],

      ),
    );
  }
}

