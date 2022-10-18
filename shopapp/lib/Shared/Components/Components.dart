import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Models/On_BoardingModel.dart';

Widget OnBoardingItem(OnBoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Image(
        image: AssetImage('${model.image}'),
      ),
    ),
    SizedBox(height: 20,),
    Text(
      '${model.title}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    ),
    SizedBox(height: 15,),
    Text(
      '${model.body}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
);

void navigateTo(Widget,context) => Navigator.push(context,
    MaterialPageRoute(builder:(context)=> Widget));

void navigateToAndReplace(Widget,context) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder:(context)=> Widget),
    (Route<dynamic> route )=>false,
);

Widget DefaultButton ({
  required Function? onpressed(),
  required String text,
})=>Container(
  height: 50,
  width: double.infinity,
  child:   MaterialButton(
    color: Colors.deepPurple,
    onPressed: onpressed,
    child: Text(
      '${text}',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);


void ShowToast({
  required String message,
  required ToastStates state,
  ToastGravity place=ToastGravity.BOTTOM,
}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,//Short 1 sec , Long 5 sec
    gravity: place ,//the place of show center , bottom
    timeInSecForIosWeb: 5,//for IOS and web
    backgroundColor: ChoseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS , ERROR, WARNING}
Color ChoseToastColor(ToastStates state){
  switch(state){
    case ToastStates.SUCCESS :
      return Colors.green;
      break;
    case ToastStates.ERROR :
      return Colors.red;
      break;
    case ToastStates.WARNING:
      return Colors.yellow;
      break;
    default : return Colors.orange;
  }
}
