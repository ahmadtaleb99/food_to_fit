import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key,  this.message,this.color}) : super(key: key);
  final String?  message ;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color ?? CustomColors.PrimaryColor),
          ),
          SizedBox(height: 10,),
          if(message!= null ) Text(message!,style: TextStyle(color: color ,fontWeight: FontWeight.bold),)

        ],
      ),
    );
  }
}
