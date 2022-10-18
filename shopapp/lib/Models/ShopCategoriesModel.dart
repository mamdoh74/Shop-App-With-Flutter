class CategoriesModel{
  bool? status;
  String? message;
  DataModel? data;

  CategoriesModel.fromjson(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json[message];
    data=DataModel.fromjson(json['data']);
  }
}
class DataModel{
  int? current_page;
  List<categoModel>? data=[];
  DataModel.fromjson(Map<String,dynamic> json)
  {
    current_page = json['current_page'];
    for(int i=0;i<json['data'].length;i++)
      {
        data!.add(categoModel.fromjson(json['data'][i]));
      }
  }
}

class categoModel{
  int? id;
  String? name;
  String? image;
  categoModel.fromjson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}