import 'package:easy_localization/easy_localization.dart';
import 'package:food_to_fit/AppPreferences.dart';

import '../widgets/di.dart';

class DateManager{
  static const String dateFormat = ' MM/dd/yyyy  HH:MM';

  static  String getFormatedDate(String date){
    return DateFormat('MM/dd/yyyy    HH:MM').format(DateTime.parse(date));

  }

  static  String getFormatedDateRtl(String date){

    final format = getIT<AppPreferences>().isRtl()   ? 'HH:MM MM/dd/yyyy  ' : ' MM/dd/yyyy  HH:MM';

    return DateFormat(format).format(DateTime.parse(date));

  }
}