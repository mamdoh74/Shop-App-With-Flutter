class ProductsModel{
  bool? status;
  String? message;
  DataModel? data;

  ProductsModel.fromjson(Map<String,dynamic> json)
  {
    status= json['status'];
    message=json['message'];
    data=DataModel.fromjson(json['data']) ;
  }
}
class DataModel{
  List<bannersModel>? banners=[];
  List<ProductModel>? products=[];
  String? ad;

  DataModel.fromjson(Map<String,dynamic> json)
  {
    for(int i=0;i<json['banners'].toList().length ;i++)
      {
        banners!.add(bannersModel.fromjson(json['banners'][i]));
      }
    print('done');

    for(int i=0;i<json['products'].toList().length ;i++)
    {
      products!.add(ProductModel.fromjson(json['products'][i]));
    }
    /*
    json['banners']!.forEach((element){
      banners!.add(element);
    });
    json['products'].forEach((element){
      products!.add(element);
    });

     */

    ad=json['ad'];

  }

}
class bannersModel{
  int? id;
  String? image;


  bannersModel.fromjson(Map<String, dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}
class ProductModel{
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<dynamic>? images;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromjson(Map<String, dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    images=json['images'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}