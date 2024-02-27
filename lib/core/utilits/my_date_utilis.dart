import 'package:intl/intl.dart';

class MyDataUtilis{
  static String formateTaskDate(DateTime dateTime){
    var formatedate = DateFormat("yyyy MMM dd");
    return formatedate.format(dateTime);
  }
}