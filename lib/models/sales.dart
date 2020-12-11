

class sales_get{
  int sale_id;
  int order_id;
  String time;
  String day;
  String month;
  String year;
  int order_total;


  sales_get.fromJson(Map<String,dynamic> json){

    sale_id=json["sale_id"];
    order_id=json["order_id"];
    time=json["order_time"];
    day=json["order_day"];
    month=json["order_month"];
    year=json["order_year"];
    order_total=json["order_total"];
  }

  sales_get(this.sale_id,this.order_id,this.time,this.day,this.month,this.year,this.order_total);

  toJson() => {
    'sale_id':sale_id,
    'order_id': order_id,
    'order_time':time,
    'order_day':day,
    'order_month':month,
    'order_year':year,
    'order_total':order_total,


  };

}

class sales_post{
  int order_id;
  String time;
  String day;
  String month;
  String year;
  int order_total;
  //String order_status;


  sales_post.fromJson(Map<String,dynamic> json){
    order_id=json["order_id"];
    time=json["order_time"];
    day=json["order_day"];
    month=json["order_month"];
    year=json["order_year"];
    order_total=json["order_total"];
    //time_stamp=json["time_stamp"];
    //order_status=json["order_status"];

  }

  sales_post(this.order_id,this.time,this.day,this.month,this.year,this.order_total);

  toJson() => {

    'order_id': order_id,
    'order_time': time,
    'order_day': day,
    'order_month': month,
    'order_year': year,
    'order_total':order_total,



  };

}
