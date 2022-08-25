import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key,  this.message}) : super(key: key);
  final String?  message ;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.PrimaryColor),
          ),
          SizedBox(height: 10,),
          if(message!= null ) Text(message!)

        ],
      ),
    );
  }
}
