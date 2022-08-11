import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/models/visitModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VisitDetailsTableWidget {
  Widget getVisitDetailsTable(
      BuildContext context, Visit? visit, bool isPayment) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
          border: Border.all(color: CustomColors.GreyBorderColor),
          color: Colors.white),
      child: isPayment
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText('Date and Time'.tr(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      maxFontSize: 14),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: CustomColors.GreyBorderColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    visit!.dateTime!,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    maxFontSize: 12,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: CustomColors.GreyBorderColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    'Diagnosis'.tr(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    maxFontSize: 14,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: CustomColors.GreyBorderColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    visit.diagnosis!,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                    maxFontSize: 12,
                  ),
                ),
                SizedBox(height: 10.0),
                visit.payment != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Divider(
                              color: CustomColors.GreyBorderColor,
                              thickness: 1.0,
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText(
                                'Payment'.tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                maxFontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Divider(
                              color: CustomColors.GreyBorderColor,
                              thickness: 1.0,
                            ),
                            // SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: AutoSizeText(
                                visit.payment!.type!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                                maxFontSize: 12,
                              ),
                            )
                          ])
                    : Container(),
                SizedBox(height: 10.0),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                //   child: AutoSizeText(
                //     'Date',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14.0),
                //     maxFontSize: 14,
                //   ),
                // ),
                // SizedBox(height: 10.0),
                // Divider(
                //   color: CustomColors.GreyBorderColor,
                //   thickness: 1.0,
                // ),
                // SizedBox(height: 10.0),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                //   child: AutoSizeText(
                //     visit.payment.date,
                //     style: TextStyle(color: Colors.black, fontSize: 12.0),
                //     maxFontSize: 12,
                //   ),
                // ),
                // SizedBox(height: 10.0),
                // Divider(
                //   color: CustomColors.GreyBorderColor,
                //   thickness: 1.0,
                // ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    'Amount'.tr(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxFontSize: 14,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: CustomColors.GreyBorderColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    visit!.payment!.amount!,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                    maxFontSize: 12,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: CustomColors.GreyBorderColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    'Notes',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxFontSize: 14,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: CustomColors.GreyBorderColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    visit.payment!.notes!,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                    maxFontSize: 12,
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
    );
  }
}
