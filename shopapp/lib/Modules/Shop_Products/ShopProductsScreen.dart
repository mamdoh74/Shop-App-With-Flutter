import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Models/ShopProductsModel.dart';
import 'package:shopapp/Shared/Components/Components.dart';
import 'package:shopapp/Shared/Network/local/Shared_Preferences/Cache_Helper.dart';
import 'package:shopapp/Shared/cubit/Cubit.dart';
import 'package:shopapp/Shared/cubit/States.dart';

import '../../Models/ShopCategoriesModel.dart';
import '../../Shared/Components/Constants.dart';

class ShopProductsScreen extends StatelessWidget {
  const ShopProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context,state){
        if(state is ShopProductsErrorState)
          {
            print(state.error);
          }
        if(state is ShopChangeFavouritesSuccessState)
          {
            if(!state.model.status!)
              ShowToast(state: ToastStates.ERROR,message: state.model.message!);
          }
      },
      builder: (context,state){
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.products != null,
            builder: (context) => builderItem(cubit.products!,cubit.Categorymodel!,context),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          )
        );
      },
    );
  }
  Widget builderItem(ProductsModel model,CategoriesModel Catmodel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(), //to make animation like jumping
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners!.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.fill,
          )).toList(),
          options: CarouselOptions(
            height: 200,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).ChangeScreen(1);
                      },
                      icon: Icon(Icons.double_arrow,color: Colors.deepPurple,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemBuilder: (context,index)=>CategoriesListItem(Catmodel.data!.data![index]),
                    separatorBuilder: (context , index) =>SizedBox(width: 10,),
                    itemCount: Catmodel.data!.data!.length,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Products',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[400],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1/1.2,
              children: List.generate(
                  model.data!.products!.length,
                      (index) => GridProductsItem(model.data!.products![index],context)),
            ),
          ),
        ),
      ],
    ),
  );

  Widget GridProductsItem(ProductModel model,context) => Container(
    color:Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0)
             Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.red,
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white
                ),
              ),
            ),

          ],
        ),

        Text(
          '${model.name}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            height: 1.1,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 4,right: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${model.price}',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  height: 1.1,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              model.discount!=0 ? Text(
                '${model.old_price}',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.1,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,//make the text inlined
                ),
              ) : Text(
                '',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.1,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,//make the text inlined
                ),
              ),
              Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor: ShopCubit.get(context).favourits![model.id]! ? Colors.deepPurple : Colors.grey[300],
                child: IconButton(
                  onPressed: (){
                    ShopCubit.get(context).ChangeFavourite(model.id!);
                  },
                  icon: Icon(Icons.favorite_outline,color:Colors.white),
                ),
              ),

            ],
          ),
        )
      ],
    ),
  );

  Widget CategoriesListItem(categoModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.fill,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ],
  );


}
