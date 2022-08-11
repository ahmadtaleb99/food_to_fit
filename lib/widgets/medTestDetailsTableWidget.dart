import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/medTestModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MedTestDetailsTableWidget {
  String? medTestType;
  List<Properties>? properties;

  Widget getMedTestDetailsTableWidget(
      BuildContext context, String medTestType, List<Properties>? properties) {
    this.medTestType = medTestType;
    this.properties = properties;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
          border: Border.all(color: CustomColors.GreyBorderColor),
          color: Colors.white),
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(5.0),
            child: Text(
          medTestType,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: getTableRows(context))
      ]),
    );
  }

  List<TableRow> getTableRows(BuildContext context) {
    List<TableRow> rows = [];
    rows.add(TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: CustomColors.GreyBorderColor),
            top: BorderSide(color: CustomColors.GreyBorderColor),
          ),
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                'Test'.tr(),
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                minFontSize: 10,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color: CustomColors.GreyBorderColor),
                  left: BorderSide(color: CustomColors.GreyBorderColor)),
            ),
            child: Center(
              child: AutoSizeText(
                'Result'.tr(),
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                minFontSize: 10,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                'Normal Range'.tr(),
                style:
                    TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                minFontSize: 11,
                maxLines: 1,
              ),
            ),
          ),
        ]));

    for (int i = 0; i < properties!.length; i++) {
     var propertiy  =  properties!.elementAt(i);
      rows.add(TableRow(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                properties!.elementAt(i).name!,
                style: TextStyle(color: Colors.black, fontSize: 14),
                minFontSize: 12,
                maxLines: 1,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: CustomColors.GreyBorderColor),
                    left: BorderSide(color: CustomColors.GreyBorderColor))),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                properties!.elementAt(i).value != null
                    ? properties!.elementAt(i).value!
                    : "-",
                style: TextStyle(color: Colors.black, fontSize: 14),
                minFontSize: 12,
                // maxLines: 1,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: AutoSizeText(
                propertiy.from == null ? '-' :
                'from '.tr()+propertiy.from.toString()+' '+'to'.tr()+' '+propertiy.to.toString(),
                style: TextStyle(color: Colors.black, fontSize: 14),
                minFontSize: 12,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ));
    }
    return rows;
  }
}
