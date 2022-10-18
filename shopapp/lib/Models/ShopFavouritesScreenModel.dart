class FavouritesScreenModel{
  bool? status;
  String? message;
  Data? data;

  FavouritesScreenModel.fromjson(Map<String, dynamic> json)
  {
    status = json['status'];
    message=json['message'];
    data=Data.fromjson(json['data']);
  }
}

class Data{
  int? current_page;
  List<productListData> data=[];
  Data.fromjson(Map<String,dynamic> json)
  {
    current_page=json['current_page'];
    for(int i=0;i<json['data'].length;i++)
      {
        data.add(productListData.fromjson(json['data'][i]));
      }
  }
}

class productListData{
  int? id;
  product? prod;
  productListData.fromjson(Map<String, dynamic> json)
  {
    id=json['id'];
    prod=product.fromjons(json['product']);
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