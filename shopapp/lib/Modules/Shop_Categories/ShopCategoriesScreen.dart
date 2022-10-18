import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/cubit/Cubit.dart';
import 'package:shopapp/Shared/cubit/States.dart';

import '../../Models/ShopCategoriesModel.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state) {},
      builder: (context,state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>
                CategoriesItem(cubit.Categorymodel!.data!.data![index]),
            separatorBuilder: (context, index) => SperatorItem(),
            itemCount: cubit.Categorymodel!.data!.data!.length,
          ),
        );
      }
      );

  }

  Widget CategoriesItem(categoModel model)=> Row(
    children: [
      Image(
        image: NetworkImage(model.image!),
        height: 100,
        width: 100,
        fit: BoxFit.fill,
      ),
      SizedBox(width: 20,),
      Text(
        '${model.name}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: (){},
      ),
    ],
  );

  Widget SperatorItem()=> Column(

    children: [
      SizedBox(height: 10,),
      Container(
        color: Colors.grey,
        width: double.infinity,
        height: 1,

      ),
      SizedBox(height: 10,),
    ],
  );
}
