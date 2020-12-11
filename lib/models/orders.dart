

class orders_get{
  int order_id;
  int customer_id;
  String hash;
  String time;
  String day;
  String month;
  String year;
  String order_status;
  int order_total;
  

  orders_get.fromJson(Map<String,dynamic> json){
   
    order_id=json["order_id"];
    customer_id=json["customer_id"];
    hash=json["hash"];
    time=json["time"];
    day=json["day"];
    month=json["month"];
    year=json["year"];
    order_status=json["order_status"];
    order_total=json["order_total"];
  }
  
  orders_get(this.order_id,this.customer_id,this.hash,this.time,this.day,this.month,this.order_status);

  toJson() => {
    'order_id':order_id,
    'customer_id': customer_id,
    'hash': hash,
    'time':time,
    'day':day,
    'month':month,
    'year':year,
    'order_status':order_status,
    'order_total':order_total,
    
    
      };

}

class orders_post{
  int customer_id;
  String hash;
  String time;
  String day;
  String month;
  String year;
  String order_status;
  int order_total;
  

  orders_post.fromJson(Map<String,dynamic> json){
    customer_id=json["customer_id"];
    hash=json["hash"];
    time=json["time"];
    day=json["day"];
    month=json["month"];
    year=json["year"];
    order_status=json["order_status"];
    order_total=json["order_total"];
   
  }
  
  orders_post(this.customer_id, this.hash,this.time,this.day,this.month,this.year,this.order_status,this.order_total);

  toJson() => {
    'hash': hash,
    'customer_id': customer_id,
    'time': time,
    'day': day,
    'month': month,
    'year':year,
    'order_status': order_status,
    'order_total':order_total,
    
    
      };

}
