import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';

class ViewUpdateMenuItemPage extends StatefulWidget {

  @override
  _ViewUpdateMenuItemPageState createState() => _ViewUpdateMenuItemPageState();
}

class _ViewUpdateMenuItemPageState extends State<ViewUpdateMenuItemPage> {
  
  List<MenuGet> _menugets = List<MenuGet>();
  MenuGet menu;
  Http http = new Http();
  Color leadingBackgroundColor;
  Color leadingNumberColor;  

  deleteonPressed(BuildContext context,int id, int index) {
    http.MenuDeleteRequest(_menugets[index]);
    setState(() {
        http.getMenu().then((value) {
      setState(() {
        _menugets.clear();
        _menugets.addAll(value);
      });
    });
      });

}
  UpdateonPressed(BuildContext context,int item_id, int index) {
    
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => MenuManagement_UpdateItems(
                  menu: _menugets[index],
                )))
        .then((menu) {
      if (menu != null) {
        http.menuPutRequest(menu);
       setState(() {
        http.getMenu().then((value) {
      setState(() {
        _menugets.clear();
        _menugets.addAll(value);
      });
    });
      });
      }
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
        leadingNumberColor = Colors.yellowAccent;
      });
    }
  }
 


  @override
  void initState() {
    http.getMenu().then((value) {
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
        title: Text('McMenu'),
      ),
      body: ListView.builder(
        itemCount: _menugets.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: leadingBackgroundColor,
              child: Text(' ${_menugets[index].item_id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
            ),
            onExpansionChanged: (boo) => onExpansionChanged(boo),
            title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('${_menugets[index].item_name}'),
            Text('\$ ${_menugets[index].item_price}')]),
            // Text('${_menugets[index].item_name}'
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    raisedButton('Update',
                        onPressed: ()=>UpdateonPressed(context, _menugets[index].item_id,index),
                        fontSize: 15.0),
                    raisedButton('Delete',
                    onPressed: ()=>deleteonPressed(context, _menugets[index].item_id,index),
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
                    
