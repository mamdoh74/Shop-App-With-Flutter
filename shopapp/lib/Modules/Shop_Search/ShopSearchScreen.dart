import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Models/ShopSearchModel.dart';
import 'package:shopapp/Modules/Shop_Search/cubit/cubit.dart';

import '../../Shared/cubit/Cubit.dart';
import 'cubit/states.dart';

class ShopSearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context , state){},
        builder: (context,state){
          SearchCubit cubit=SearchCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty)
                          return 'please dont let the search empty';
                        return null;
                      },
                      onFieldSubmitted : (value){
                        if(formkey.currentState!.validate())
                          {
                            cubit.SearchProducts(value);
                          }

                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                            itemBuilder:(context,index) => SearchListItem(cubit.model!.data!.data[index],context),
                            separatorBuilder: (context,index) => Container(width: double.infinity,height: 1,color: Colors.grey,),
                            itemCount: cubit.model!.data!.data.length,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget SearchListItem(product model,context)=> Container(
    width: double.infinity,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 150,
                height: 150,
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
                  model.name!,
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
                        '${model.price!}',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                ),
              ],
            ),
          ),
        ),



      ],
    ),
  );
}
