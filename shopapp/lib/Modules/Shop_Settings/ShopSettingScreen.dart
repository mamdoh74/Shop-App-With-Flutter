import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/cubit/Cubit.dart';
import 'package:shopapp/Shared/cubit/States.dart';

import '../ShopRegister/cubit Register/Cubit.dart';

class ShopSettingsScreen extends StatelessWidget {

  var usernameController = TextEditingController();
  var useremailController = TextEditingController();
  var userphoneController = TextEditingController();

  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ShopCubit cubit=ShopCubit.get(context);
    cubit.getUserData();
    usernameController.text=cubit.userModel!.data!.name!;
    useremailController.text=cubit.userModel!.data!.email!;
    userphoneController.text=cubit.userModel!.data!.phone!;

    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context , state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder:(context)=> Container(
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    if(state is ShopUpdateLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage('${cubit.userModel!.data!.image}'),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '${cubit.userModel!.data!.name}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      controller: usernameController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText : 'username',
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                          return 'please dont let the username empty';
                        else
                          return null;
                      },

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: useremailController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText : 'Email',
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                          return 'please dont let the Email empty';
                        else
                          return null;
                      },

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: userphoneController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText : 'Phone',
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                          return 'please dont let the Phone empty';
                        else
                          return null;
                      },

                    ),
                    SizedBox(height: 40,),
                    Container(
                      width: double.infinity,
                      height: 70,
                      child: MaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate())
                            {
                              ShopCubit.get(context).userUpdate(
                                name: usernameController.text,
                                email: useremailController.text,
                                phone: userphoneController.text,
                              );
                              cubit.getUserData();
                            }
                          },
                        color: Colors.deepPurple,
                        child: Text(
                          'update',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          fallback: (context ) =>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
