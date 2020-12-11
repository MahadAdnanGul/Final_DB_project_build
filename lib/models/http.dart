import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/cashier.dart';
import 'package:frontend/models/inventory.dart';
import 'package:frontend/models/menu.dart';

import 'package:frontend/models/cart_item.dart';

import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/models/inventory.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/models/sales.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'inventory.dart';
import 'user.dart';

class Http {
  // localhost || 10.0.2.2 (mysql) || 192.168.1.165 (home) || 10.192.82.178 (eduroam) || 10.10.10.47 (PIA despscho Juanjo)
  final url = 'https://db-final-2.herokuapp.com/';
  // final users = 'dummy/';
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  Http ();

  Future<List<Customer>> getUsers() async {
    print("customer get works");
    final users='customers/';
    print('$url$users');
    http.Response response = await http.get('$url$users');
    print(response.body);
    // List<Customer> result = parseResponse_customer(response.body);
    List<Customer> result = new List<Customer>.from(json
        .decode(response.body)
        .map((jsonObject) => new Customer.fromJson(jsonObject)));
    print(result);
    result.sort((a, b) => a.id.compareTo(b.id));
    print('${getstatusCode(response.statusCode)}');
    return result;
  }

  Future<List<Cashier>> getCashier() async {
    print("cashier get works");
    final users='cashier/';
    print('$url$users');
    http.Response response = await http.get('$url$users');
    print(response.body);
    // List<Customer> result = parseResponse_customer(response.body);
    List<Cashier> result = new List<Cashier>.from(json
        .decode(response.body)
        .map((jsonObject) => new Cashier.fromJson(jsonObject)));
    print(result);
    result.sort((a, b) => a.id.compareTo(b.id));
    print('${getstatusCode(response.statusCode)}');
    return result;
  }

  makeCashierPostRequest(Cashier user) async {
    print("going to post");
    final users='cashier/';
    String body = json.encode(user.toJson());
    http.Response response =
    await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }
  makeCashierDeleteRequest(Cashier user) async {
    final users='cashier/';
    http.Response response = await http.delete('$url$users${user.id}', headers: headers);
    print(response.body);
    print('Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }
  makeCashierPutRequest(Cashier user) async {
    final users='cashier/';
    String body = json.encode(user.toJson());
    http.Response response = await http.put('$url$users${user.id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

  makeUserDeleteRequest(Customer user) async {
    final users='customers/';
    http.Response response = await http.delete('$url$users${user.id}', headers: headers);
    print(response.body);
    print('Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }
  Future<List<InventoryGet>> getInventory() async {
    print("byeee");
    final users='inventory/';
    print('$url$users');
    http.Response response = await http.get('$url$users');
    print(response.body);
    print("heloooooooooooo");
    var menuList = List<InventoryGet>();
    var menuJson= json.decode(response.body);
    for(var menu in menuJson){
      menuList.add(InventoryGet.fromJson(menu));
    }

    print(menuList);
    print("its donnee");
    return menuList;
    // List<MenuGet> result = new List<MenuGet>.from(json
    //           .decode(response.body)
    //           .map((jsonObject) => new MenuGet.fromJson(jsonObject)));

  }

  makeUserPutRequest(Customer user) async {
    final users='customers/';
    String body = json.encode(user.toJson());
    http.Response response = await http.put('$url$users${user.id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

  makeUserPostRequest(Customer user) async {
    print("going to post");
    final users='customers/';
    String body = json.encode(user.toJson());
    http.Response response =
    await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

   MenuPostRequest(MenuPost menu) async {
    print("were at menu post");
    final users='menu/';
    String body = json.encode(menu.toJson());
    print(body);
    http.Response response =
    await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    print("menu works");
    print(response.body);

  }
    InventoryPostRequest(InventoryPost menu) async {
    print("were at inv post");
    final users='inventory/';
    String body = json.encode(menu.toJson());
    print(body);
    http.Response response =
    await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    print("inv works");
    print(response.body);
  }

  Future<List<MenuGet>> getMenu() async {
    print("byeee");
    final users='menu/';
    print('$url$users');
    http.Response response = await http.get('$url$users');
    print(response.body);
    print("heloooooooooooo");
    var menuList = List<MenuGet>();
    var menuJson= json.decode(response.body);
    for(var menu in menuJson){
      menuList.add(MenuGet.fromJson(menu));
    }

    print(menuList);
    print("its donnee");
    return menuList;
    // List<MenuGet> result = new List<MenuGet>.from(json
    //           .decode(response.body)
    //           .map((jsonObject) => new MenuGet.fromJson(jsonObject)));

  }



  MenuDeleteRequest(MenuGet menu) async {
    print("reach");
    final users='menu/';
    http.Response response = await http.delete('$url$users${menu.item_id}', headers: headers);
    print("hogyaa");
    print(response.body);

  }

  menuPutRequest(MenuGet menu) async {
    final users='menu/';
    String body = json.encode(menu.toJson());
    http.Response response = await http.put('$url$users${menu.item_id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);

  }
  InventoryPutRequest(InventoryGet menu) async {
    final users='inventory/';
    String body = json.encode(menu.toJson());
    http.Response response = await http.put('$url$users${menu.num}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);

  }

  // SHOPPING CART GETTERS SETTERS
  ShoppingCartPostRequest(cartItem_post cart_item) async {
    print("shopping cart http.dart");
    final users='cartItem/';
    String body = json.encode(cart_item.toJson());
    print(body);
    print('$url$users');
    http.Response response = await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    // print("menu works");
    print(response.body);
  }

  Future<List<cartItem_get>> getCartItems(int customer_id) async {
    // print("byeee");
    print("GET CART ITEMS STARTS HEREE");
    // print(customer_id);
    final users='cartItem/';
    print('$url$users'+'/'+'$customer_id');
    http.Response response = await http.get('$url$users'+'/'+'$customer_id');
    print("heloooooooooooo");
    var cartList = List<cartItem_get>();
    var cartJson= json.decode(response.body);
    print(response.body);
    print("this is cart json");
    // print(cartJson);
    for(var cart in cartJson){
      cartList.add(cartItem_get.fromJson(cart));
    }

    print("its donnee");
    return cartList;
    // List<MenuGet> result = new List<MenuGet>.from(json
    //           .decode(response.body)
    //           .map((jsonObject) => new MenuGet.fromJson(jsonObject)));

  }
  // FOR ORDERS

  ordersPostrequest(orders_post order) async {
    print("shopping cart http.dart");
    final users='order/';
    String body = json.encode(order.toJson());
    print(body);
    print('$url$users');
    http.Response response = await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    // print("menu works");
    print(response.body);
  }

  salesPostrequest(sales_post order) async {
    print("shopping cart http.dart");
    final users='sales/';
    String body = json.encode(order.toJson());
    print(body);
    print('$url$users');
    http.Response response = await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    // print("menu works");
    print(response.body);
  }

  deletecart(int serial_number) async{
    final users='cartItem/';
    print('$url$users'+'/'+'$serial_number');
    http.Response response = await http.delete('$url$users'+'/'+'$serial_number', headers: headers);
    print("hogyaa delete");
    print(response.body);
  }

  updatecart(cartItem_update cart_item) async {
    final users='cartItem/';

    String body = json.encode(cart_item.toJson());
    http.Response response = await http.put('$url$users${cart_item.serial_number}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(cart_item.serial_number);

  }
  updatecart2(cartItem_update2 cart_item) async {
    final users='cartitem2/';
    print("cart_Update2");
    String body = json.encode(cart_item.toJson());
    http.Response response = await http.put('$url$users${cart_item.customer_id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(cart_item.customer_id);

  }

  Future<List<orders_get>> OrderGet() async {
    print("byeee");
    final users='order/';
    print('$url$users');
    http.Response response = await http.get('$url$users');
    print(response.body);
    print("heloooooooooooo");
    var menuList = List<orders_get>();
    var menuJson= json.decode(response.body);
    for(var menu in menuJson){
      menuList.add(orders_get.fromJson(menu));
    }

    print(menuList);
    print("its donnee");
    return menuList;
    // List<MenuGet> result = new List<MenuGet>.from(json
    //           .decode(response.body)
    //           .map((jsonObject) => new MenuGet.fromJson(jsonObject)));

  }

  OrderPutRequest(orders_get menu) async {
    final users='order/';
    String body = json.encode(menu.toJson());
    http.Response response = await http.put('$url$users${menu.order_id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);

  }
  Future<List<sales_get>> SalesGet() async {
    print("byeee");
    final users='sales/';
    print('$url$users');
    http.Response response = await http.get('$url$users');
    print(response.body);
    print("heloooooooooooo");
    var menuList = List<sales_get>();
    var menuJson= json.decode(response.body);
    for(var menu in menuJson){
      menuList.add(sales_get.fromJson(menu));
    }

    print(menuList);
    print("its donnee");
    return menuList;
    // List<MenuGet> result = new List<MenuGet>.from(json
    //           .decode(response.body)
    //           .map((jsonObject) => new MenuGet.fromJson(jsonObject)));

  }

  /*Future<List<sales_get>> SalesGet_month(String order_month,String order_year) async {
    print("byeee");
    final users='sales/';
    print('$url$users');
    http.Response response = await http.get('$url$users$order_month$order_year');
    print(response.body);
    print("heloooooooooooo");
    var menuList = List<sales_get>();
    var menuJson= json.decode(response.body);
    for(var menu in menuJson){
      menuList.add(sales_get.fromJson(menu));
    }

    print(menuList);
    print("its donnee");
    return menuList;
    // List<MenuGet> result = new List<MenuGet>.from(json
    //           .decode(response.body)
    //           .map((jsonObject) => new MenuGet.fromJson(jsonObject)));

  }*/




}

  


      

    
//     List<MenuGet> parseResponse(String body) {
//       final parsed = json.decode(body).cast<Map<String,dynamic>>();
//       return parsed;
// }

