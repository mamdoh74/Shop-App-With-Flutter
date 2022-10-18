class ShopSearchModel{
  bool? status;
  String? message;
  Data? data;

  ShopSearchModel.fromjson(Map<String, dynamic> json)
  {
    status = json['status'];
    message=json['message'];
    data=Data.fromjson(json['data']);
  }
}

class Data{
  int? current_page;
  List<product> data=[];
  Data.fromjson(Map<String,dynamic> json)
  {
    current_page=json['current_page'];
    for(int i=0;i<json['data'].length;i++)
    {
      data.add(product.fromjons(json['data'][i]));
    }
  }
}

class product{
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  product.fromjons(Map<String, dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];

  }

}