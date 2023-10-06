import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator<String>? validate,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmit,
  String? labelText,
  String? hintText,
  IconData? prefix,
  IconData? suffix,
  bool obscureText = false,
  Function()? suffixPressed,
  double radius = 1.0,
}) =>
    TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: type,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffixPressed,
                )
              : null),
    );

Widget defaultButton({
  double radius = 15.0,
  Color color = Colors.blue,
  required VoidCallback onPressed,
  required String text,
  double ? width,
}) =>
    Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ));


Widget devider() =>Padding(padding: const EdgeInsets.symmetric(
  horizontal: 8,
  vertical: 5
),child: Container(
  height: 1,
  color: Colors.grey[350],
),);



void showToast({
  required String message,
  required ToastStates state
})=>
    Fluttertoast.showToast
      (
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );


enum ToastStates{success,error ,warning,}

Color changeToastColor (ToastStates state){
  Color ? color;
  switch(state){
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}