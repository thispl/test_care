import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl_browser.dart';



getFormatted(value){
  DateTime date = DateTime.parse(value);
var formatter = new DateFormat.yMMMMd();
String formattedDate = formatter.format(date);
return formattedDate.toString();
}
