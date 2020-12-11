

class MenuGet{
  int item_id;
  int item_price;
  String item_name;

  MenuGet.fromJson(Map<String,dynamic> json){
    item_id=json["item_id"];
    item_price=json["item_price"];
    item_name=json["item_name"];
  }
  
  MenuGet(this.item_id,this.item_price, this.item_name);

  toJson() => {
    'item_id': item_id,
    'item_name': item_name,
    'item_price': item_price,
    
      };

}

class MenuPost{
  int item_price;
  String item_name;

  // MenuPost(int item_price, String item_name){
  //   item_price= item_price;
  //   item_name= item_name;
  // }  
  MenuPost(this.item_price, this.item_name);

  toJson() => {
    'item_name': item_name,
    'item_price': item_price,
    
      };

}
