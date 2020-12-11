

class cartItem_get{
  int serial_number;
  int customer_id;
  int product_price;
  String product_name;
  int product_quantity;
  String hash;
  String status;

  cartItem_get.fromJson(Map<String,dynamic> json){
   
    serial_number=json["serial_number"];
    customer_id=json["customer_id"];
    product_price=json["product_price"];
    product_name=json["product_name"];
    product_quantity=json["product_quantity"];
    hash=json["hash"];
    status=json["status"];
  }
  
  cartItem_get(this.serial_number,this.customer_id,this.product_price, this.product_name,this.product_quantity,this.hash,this.status);

  toJson() => {
    'customer_id':customer_id,
    'product_name': product_name,
    'product_price': product_price,
    'product_quantity':product_quantity,
    'hash':hash,
    'status':status
    
      };

}


class cartItem_post{
  int customer_id;
  int item_price;
  String item_name;
  int item_quantity;
  String hash;
  String status;

  cartItem_post.fromJson(Map<String,dynamic> json){
    customer_id=json["customer_id"];
    item_price=json["item_price"];
    item_name=json["item_name"];
    item_quantity=json["item_quantity"];
    hash=json["hash"];
    status=json["status"];
  }

  
  cartItem_post(this.item_price,this.customer_id, this.item_name,this.item_quantity,this.hash,this.status);

  toJson() => {
    'customer_id':customer_id,
    'item_name': item_name,
    'item_price': item_price,
    'item_quantity':item_quantity,
    'hash':hash,
    'status':status
    
      };

}
class cartItem_update{
  int product_quantity;
  int serial_number;
  cartItem_update(this.product_quantity,this.serial_number);

  toJson() => {
    'product_quantity':product_quantity,
    'serial_number': serial_number,

  };
}

class cartItem_update2{
  String hash;
  String status;
  int customer_id;
  cartItem_update2(this.hash,this.status,this.customer_id);

  toJson() => {
    'hash':hash,
    'status': status,
    'customer_id':customer_id,

  };
}


