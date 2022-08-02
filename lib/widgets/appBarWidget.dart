import 'package:flutter/material.dart';

class AppBarWidget{
  Widget appBarWidget(Widget title) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: title,
      centerTitle: true,
    );
  }

  Widget appBarWidgetWithoutBack(Widget title) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Container(),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: title,
      centerTitle: true,
    );
  }
}