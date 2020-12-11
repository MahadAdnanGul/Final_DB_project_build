import 'dart:io';

import 'package:flutter/material.dart';
class InventoryGet{
  int num;
  int quantity;
  String product_name;
  int product_id;
  // File item_image;

  InventoryGet.fromJson(Map<String,dynamic> json){
    num=json["num"];
    quantity=json["quantity"];
    product_name=json["product_name"];
    product_id=json["product_id"];
    //item_image=json["item_image"];

  }
  InventoryGet(this.num,this.quantity,this.product_name,this.product_id);
  toJson() => {
    'num': num,
    'quantity': quantity,
    'product_name': product_name,
    'product_id': product_id,
  };




}

class InventoryPost{
  int quantity;
  String product_name;
  int product_id;

  // MenuPost(int item_price, String item_name){
  //   item_price= item_price;
  //   item_name= item_name;
  // }
  InventoryPost(this.quantity, this.product_name,this.product_id);

  toJson() => {
    'quantity': quantity,
    'product_name': product_name,
    'product_id' : product_id,

  };

}
