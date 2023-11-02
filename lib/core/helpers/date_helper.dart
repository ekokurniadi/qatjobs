import 'package:intl/intl.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';

class DateHelper{
  const DateHelper._();

  static String formatdMy(String? date){
    if(GlobalHelper.isEmpty(date)){
      return '';
    }

    return DateFormat('d MMM yyyy').format(DateTime.parse(date!));
  }
  static String getOnlyDate(String? date){
    if(GlobalHelper.isEmpty(date)){
      return '';
    }

    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date!));
  }
}