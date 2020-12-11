import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/models/sales.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';




/*class AnalPage extends StatelessWidget {
  var Date=DateTime.now();
  var Selected_date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      floatingActionButton: new Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.amber,
        ),
        child: new Builder(
          builder: (context) => new FloatingActionButton(
            child: new Icon(Icons.date_range),
            onPressed: () => showDatePicker(
              context: context,
              initialDate: Date,
              firstDate:
              Date.subtract(new Duration(days:3000)),
              lastDate: Date.add(new Duration(days: 3000)),

            ),
          ),
        ),
      ),
      body: Center(
      ),
    );
  }
}*/
//this is an external package for formatting date and time

class AnalPage extends StatefulWidget {

  @override
  _AnalPageState createState() => new _AnalPageState();
}

class _AnalPageState extends State<AnalPage> {
  var finaldate;
  List<sales_get> _menugets = List<sales_get>();
  //List<sales_get> updatedlist=List<sales_get>();
  int total_count=0;
  int total_rev=0;
  String updated_month="12";
  String updated_year="2020";
  String updated_day='10';
  String format="blac";
  MenuGet menu;
  Http http = new Http();

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = order;
      updated_month=order.month.toString();
      updated_year=order.year.toString();
      updated_day=order.day.toString();
      format=updated_year+'-'+updated_month;

    });
    total_rev=0;
    total_count=0;
    for(int i=0;i<_menugets.length;i++)
      {
        if(_menugets[i].month==updated_month&&_menugets[i].year==updated_year)
          {
            total_count++;
            total_rev=total_rev+_menugets[i].order_total;
          }
      }
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    http.SalesGet().then((value) {
      setState(() {
        _menugets.addAll(value);
        print(_menugets[0].order_total);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("McAnalytics"),
      ),
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: finaldate == null
                  ? Text(
                "0000-00",
                textScaleFactor: 2.0,
              )
                  : Text(
                "$format",
                textScaleFactor: 3.0,
              ),
            ),
            new RaisedButton(
              onPressed: callDatePicker,
              color: Colors.yellow,
              child:
              new Text('Select Month', style: TextStyle(color: Colors.redAccent)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),

            ),
            Text("Number of sales: "+total_count.toString(),textScaleFactor: 2.0,),
            Text("Total revenue: "+total_rev.toString(),textScaleFactor: 2.0,),
          ],
        ),
      ),
    );
  }
}
