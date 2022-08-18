import 'package:easy_localization/easy_localization.dart';
import 'package:food_to_fit/AppPreferences.dart';

import '../widgets/di.dart';

class DateManager{
  static const String dateFormat = ' MM/dd/yyyy  HH:MM';

  static getFormattedDate(String date){
    return DateFormat('MM/dd/yyyy    HH:MM').format(DateTime.parse(date));

  }

  static  String getFormattedDateRtl(String date){

    final format = getIT<AppPreferences>().isRtl()   ? 'HH:MM MM/dd/yyyy  ' : ' MM/dd/yyyy  HH:MM';

    return DateFormat(format).format(DateTime.parse(date));

  }
}