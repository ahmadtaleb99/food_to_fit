import 'package:flutter/material.dart';

class VisitDetailsTableFieldWidget{
  Widget getVisitDetailsTableFieldWidget(String title, String value){
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 10.0),
        Divider(
            color: Colors.grey
        ),
        SizedBox(height: 10.0),
        Text(value, style: TextStyle(color: Colors.black, fontSize: 14.0)),
        SizedBox(height: 10.0),
        Divider(
            color: Colors.grey
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}