import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/Pages/newmenu.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/cart_item.dart';
import 'package:frontend/models/inventory.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/Pages/newinventory.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';

import '../models/cart_item.dart';
import '../models/cart_item.dart';
import '../models/user.dart';

class ShoppingCartPage extends StatefulWidget {
  int final_index;
  ShoppingCartPage({this.final_index});
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  List<cartItem_get> _cartgets = List<cartItem_get>();
  List<InventoryGet> _inventorygets = List<InventoryGet>();
  List<Customer> users = [];
  int Total=0;
  cartItem_get cart;
  Http http = new Http();
  List<String> arr=[];
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  addQuantity(int quantity,int index){
    setState(() {
      _cartgets[index].product_quantity++;
      quantity++;

    });
    // also increase in mysql
    cartItem_update c = new cartItem_update(quantity++,_cartgets[index].serial_number);
   http.updatecart(c);
    CalculateTotal(_cartgets, _cartgets[index].customer_id);

  }

  subtractQuantity(int quantity,index){
    if(quantity==1){
      // delete item from cart
      http.deletecart(_cartgets[index].serial_number);
      setState(() {
        _cartgets.removeAt(index);

        // also decrease in mysql
      });
    }
    else{
      setState(() {
        _cartgets[index].product_quantity--;
        quantity--;
        // also decrease in mysql

      });
      cartItem_update c = new cartItem_update(quantity--,_cartgets[index].serial_number);
     http.updatecart(c);
    }
    CalculateTotal(_cartgets, _cartgets[index].customer_id);


  }



  // deleteonPressed(BuildContext context,int id, int index) {
  //   http.MenuDeleteRequest(_menugets[index]);
  //   setState(() {
  //     http.getMenu().then((value) {
  //       setState(() {
  //         _menugets.clear();
  //         _menugets.addAll(value);
  //       });
  //     });
  //   });

  // }
  // UpdateonPressed(BuildContext context,int item_id, int index) {

  //   Navigator.of(context)
  //       .push(MaterialPageRoute(
  //       builder: (context) => MenuManagement_UpdateItems(
  //         menu: _menugets[index],
  //       )))
  //       .then((menu) {
  //     if (menu != null) {
  //       http.menuPutRequest(menu);
  //       setState(() {
  //         http.getMenu().then((value) {
  //           setState(() {
  //             _menugets.clear();
  //             _menugets.addAll(value);
  //           });
  //         });
  //       });
  //     }
  //   });

  // }

  // Addtocart(MenuGet m,int customer_id){
  //   print(m.item_name);
  //   print(m.item_price);
  //   print(customer_id);
  //   cartItem_post cart_item = new cartItem_post(m.item_price,customer_id,m.item_name,1,"h","NP");
  //   http.ShoppingCartPostRequest(cart_item);

  //   // create a object of class cart_item which holds id,item name, quanity set to 1
  //   // ,price, hash set to 'n',and status set to NP
  //   // we will then invoke the http function and send this to the sql table
  // }
  VerifyOrder(List<cartItem_get> _cartgets,List<InventoryGet> _inventorygets,int customer_id){
    print("in verify");
    int indexI=_inventorygets.length;
    int indexC=_cartgets.length;
    print("VERUIFY LENGTH "+indexC.toString());
    for(int i=0;i<indexC;i++)
      {
        if(_cartgets[i].customer_id==customer_id&&_cartgets[i].status=="NP")
          {
            //print("found customer");
            //print(indexI);
            for(int j=0;j<indexI;j++)
              {
                if(_cartgets[i].product_name==_inventorygets[j].product_name)
                  {

                    //print("found u n*****");
                    if(_cartgets[i].product_quantity>_inventorygets[j].quantity)
                      {
                        print("Overflow");
                        openDialog(context, "Out of stock");
                        return false;

                      }
                  }
              }
          }
      }

    PlaceOrder(customer_id);
    UpdateInventoryAfterOrder(_cartgets,_inventorygets,customer_id);
    openDialog(context, "Borgor is on its way");





  }


  CalculateTotal(List<cartItem_get> _cartgets,int customer_id)
  {
    Total=0;
    int indexC=_cartgets.length;
    print("ID "+customer_id.toString());
    for(int i=0;i<indexC;i++)
      {
        if(_cartgets[i].customer_id==customer_id && _cartgets[i].status=="NP")
          {
            print("FOUND");
            Total=Total+ _cartgets[i].product_price * _cartgets[i].product_quantity;
          }
      }
    print("total "+Total.toString());

  }

  UpdateInventoryAfterOrder(List<cartItem_get> _cartgets,List<InventoryGet> _inventorygets,int customer_id){
    print("in verify");
    int indexI=_inventorygets.length;
    int indexC=_cartgets.length;
    for(int i=0;i<indexC;i++)
    {
      if(_cartgets[i].customer_id==customer_id&&_cartgets[i].status=="NP")
      {
        //print("found customer");
        //print(indexI);
        for(int j=0;j<indexI;j++)
        {
          if(_cartgets[i].product_name==_inventorygets[j].product_name)
          {
            _inventorygets[j].quantity-=_cartgets[i].product_quantity;
            http.InventoryPutRequest(_inventorygets[j]);
            //print("found u n*****");

          }
        }
      }
    }





  }

  void openDialog(BuildContext context, String dialogContent) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text('Attention'),
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


  PlaceOrder(int customer_id){
    String timestamp= DateTime.now().millisecondsSinceEpoch.toString()+customer_id.toString();
    var timestamp2=DateTime.now();
    int hour=timestamp2.hour.toInt();
    String hour_string=hour.toString();
    if(hour<10)
      {
        hour_string='0'+hour.toString();
      }
    int min=timestamp2.minute.toInt();
    String min_string=min.toString();
    if(min<10)
    {
      min_string='0'+min.toString();
    }

    String time=hour_string+':'+min_string;
    String month=timestamp2.month.toString();
    String day=timestamp2.day.toString();
    String year=timestamp2.year.toString();
    // convert timestamp into a hash
    var bytes1 = utf8.encode(timestamp);         // data being hashed
    var digest1 = sha256.convert(bytes1);
    String hash = digest1.toString().substring(0,48);
   // String time = new DateTime.now().toString();
    // send to orders table
    orders_post m = new orders_post(customer_id,hash,time,day,month,year,"pending",Total);
    cartItem_update2 c= new cartItem_update2(m.hash, 'P', m.customer_id);

    http.ordersPostrequest(m);
    http.updatecart2(c);
    // update shopping cart table

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
    http.getCartItems(widget.final_index).then((value) {
      setState(() {
        _cartgets.addAll(value);
      });
    }


    );
    http.getInventory().then((value) {
      setState(() {
        _inventorygets.addAll(value);
      });
    }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    CalculateTotal(_cartgets,widget.final_index);

    if (users.isEmpty) {
      setState(() {
        users = Provider.of<List<Customer>>(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: _cartgets.length,
        itemBuilder: (context, index) {

                    return ExpansionTile(
                      onExpansionChanged: (boo) => onExpansionChanged(boo),
                      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('${_cartgets[index].product_name}'),
                            Text('\$ ${_cartgets[index].product_price}')]),
                      // Text('${_menugets[index].item_name}'
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                raisedButton('PlaceOrder',
                                    onPressed: ()=>VerifyOrder(_cartgets,_inventorygets,widget.final_index)



                                    ,
                                    fontSize: 15.0),
                                raisedButton('Plus',
                                    onPressed: ()=>addQuantity(_cartgets[index].product_quantity,index)



                                    ,
                                    fontSize: 15.0),
                                raisedButton('Minus',
                                    onPressed: ()=>subtractQuantity(_cartgets[index].product_quantity,index)



                                    ,
                                    fontSize: 15.0),
                                Text('${_cartgets[index].product_quantity}')

                              ],
                            ),
                                  ),

                                ],
                              );

                            }

                            ),
                            bottomSheet: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Container(
                                  child: Text("TOTAL: "+Total.toString()),



                              ),


                            ),





                        );
  }
}


