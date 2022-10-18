class ShopLoginModel{
  bool? status;
  String? message;
  UserDataModel? data;

  ShopLoginModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    message=json['message'];
    data=json['data'] !=null ? UserDataModel.fromjason(json['data']) : null;
    // if it has no value make it null if the inconmming data not come make it null
    // if the incomming data not null get a object from UserDataModel the second constructor of it
    // and give each variable its value
  }
}

class UserDataModel
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserDataModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.credit,
    this.points,
    this.token,
}){}

  UserDataModel.fromjason(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    image=json['image'];
    credit=json['credit'];
    points=json['points'];
    token=json['token'];



  }

}