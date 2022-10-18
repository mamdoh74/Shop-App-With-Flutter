import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Modules/ShopRegister/cubit%20Register/Cubit.dart';
import 'package:shopapp/Modules/Shop_Login/ShopLogin.dart';

import '../../Layout/Shop_Layout/ShopLayout.dart';
import '../../Shared/Components/Components.dart';
import '../../Shared/Components/Constants.dart';
import '../../Shared/Network/local/Shared_Preferences/Cache_Helper.dart';
import '../Shop_Login/cubit/Cubit.dart';
import 'cubit Register/States.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  bool isvisible = false;

  var formKey = GlobalKey<FormState>();

  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var phoneController=TextEditingController();

  var nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : BlocProvider(
        create:(context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context,state){
            if(state is ShopRegisterSuccessState)
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
                            'Register',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Register to brows our hot offers in app',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 40,),
                          TextFormField(
                            controller: nameController,
                            validator: (String? value) {
                              if(value!.isEmpty)
                              {
                                return 'Please Enter Your Name';
                              }
                              else
                                return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            controller: emailController,
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
                            controller: phoneController,
                            validator: (String? value) {
                              if(value!.isEmpty)
                              {
                                return 'Please Enter Your phone';
                              }
                              else
                                return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'phone',
                              prefixIcon: Icon(Icons.phone),
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
                            condition: state is! ShopRegisterLoadingState,
                            builder:(context)=> DefaultButton(
                                onpressed: (){
                                  if(formKey.currentState!.validate())
                                  {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Register'
                            ),
                            fallback:(context)=>  Center(child: CircularProgressIndicator(),),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' have an account !! ',
                              ),
                              TextButton(
                                onPressed: (){
                                  navigateTo(ShopLogin(), context);
                                },
                                child: Text('Login Now'),
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

      )
    );
  }
}
