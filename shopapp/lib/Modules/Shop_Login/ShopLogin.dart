import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Modules/ShopRegister/Register_Screen.dart';
import 'package:shopapp/Shared/Network/local/Shared_Preferences/Cache_Helper.dart';

import '../../Layout/Shop_Layout/ShopLayout.dart';
import '../../Shared/Components/Components.dart';
import '../../Shared/Components/Constants.dart';
import 'cubit/Cubit.dart';
import 'cubit/States.dart';

class ShopLogin extends StatefulWidget {


  @override
  State<ShopLogin> createState() => _ShopLoginState();

}

class _ShopLoginState extends State<ShopLogin> {
  var usernameController=TextEditingController();

  var passwordController=TextEditingController();


  bool isvisible = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
            {
              if(state.model.status!)
                {
                  ShowToast(
                    message: state.model.message!,
                    state: ToastStates.SUCCESS,);
                  CacheHelper.PutData(key: 'userToken', value: state.model.data!.token);
                  token = CacheHelper.getData(key: 'userToken');
                  navigateToAndReplace(ShopLayout(), context);

                }
              else {
                print('Faild to login '+state.model.message!);
                ShowToast(
                    message: state.model.message!,
                    state : ToastStates.ERROR,);
              }
            }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Login to brows our hot offers in app',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 40,),
                        TextFormField(
                          controller: usernameController,
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please Enter Your email';
                            }
                            else
                              return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !isvisible,
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please Enter Your Password';
                            }
                            else
                              return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: IconButton(
                                icon: isvisible ? Icon(Icons.visibility): Icon(Icons.visibility_off),
                                onPressed: (){
                                  setState(() {
                                    isvisible=!isvisible;
                                  });
                                },
                              )
                          ),
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder:(context)=> DefaultButton(
                              onpressed: (){
                                if(formKey.currentState!.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: usernameController.text,
                                      password: passwordController.text,
                                    );
                                  }
                              },
                              text: 'Login'
                          ),
                          fallback:(context)=>  Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account !! ',
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(Register_Screen(), context);
                              },
                              child: Text('Register Now'),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
