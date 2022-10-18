import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/cubit/Cubit.dart';
import 'package:shopapp/Shared/cubit/States.dart';

import '../../Models/ShopFavouritesScreenModel.dart';

class ShopFavoritesScreen extends StatelessWidget {
  const ShopFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context ,state) {},
      builder:(context,state) {
        return ConditionalBuilder(
            condition: cubit.getFavo != null ,
            builder: (context)=> ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder:(context,index)=> FavouriteListItem(cubit.getFavo!.data!.data[index],context),
              separatorBuilder: (context,index)=> Container(
                color: Colors.grey,
                height: 1,
                width: double.infinity,
              ),
              itemCount: cubit.getFavo!.data!.data.length,
            ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget FavouriteListItem(productListData model,context)=> Container(
    width: double.infinity,
    child: Row(

      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.prod!.image!}'),
                width: 150,
                height: 150,
              ),
              if(model.prod!.discount! != 0)
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
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            height: 150,
            child: Column(
              children: [
                Text(
                  '${model.prod!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
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
                        '${model.prod!.price}',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      model.prod!.discount !=0 ? Text(
                        '${model.prod!.old_price}',
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
                        backgroundColor: ShopCubit.get(context).favourits![model.prod!.id]! ? Colors.deepPurple : Colors.grey[300],
                        child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).ChangeFavourite(model.prod!.id!);
                          },
                          icon: Icon(Icons.favorite_outline,color:Colors.white),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),



      ],
    ),
  );

  Widget onfavouriteEmpty() => Scaffold(
    body:  Container(
      color: Colors.red,
      child: Center(child: Column(
        children: [
          Icon(Icons.menu,
          size: 50,
          ),
          Text(
            'You Have No Favourites Yet ! Please add some',
            maxLines: 3,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      )),
    ),
  );
}
