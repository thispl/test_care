import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

setCookieVariables(){
  setUsername();
  setUserid();
}

setUsername() async {
  String fieldname = 'full_name';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  print(cookie);
  RegExp exp = new RegExp(('(^|[^;]+)\\s*' + fieldname + '\\s*=\\s*([^;]+)'));
  Iterable<Match> matches = exp.allMatches(cookie);
  for (Match m in matches) {
    String match = m.group(0);
    List cookieArr = match.split(',');
    for (var i = 0; i < cookieArr.length; i++) {
      var cookiePair = cookieArr[i].split("=");
      if (fieldname == cookiePair[0].trim()) {
        // Decode the cookie value and return
        String value = Uri.decodeComponent(cookiePair[1]);
        pref.setString('username', value).then((bool success) {
          if (success) {
            print('username is set');
          } else {
            print('Error');
          }
        });
      }
    }
  }
}

setUserid() async {
  String fieldname = 'user_id';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  print(cookie);
  RegExp exp = new RegExp(('(^|[^;]+)\\s*' + fieldname + '\\s*=\\s*([^;]+)'));
  Iterable<Match> matches = exp.allMatches(cookie);
  for (Match m in matches) {
    String match = m.group(0);
    List cookieArr = match.split(',');
    for (var i = 0; i < cookieArr.length; i++) {
      var cookiePair = cookieArr[i].split("=");
      if (fieldname == cookiePair[0].trim()) {
        // Decode the cookie value and return
        String value = Uri.decodeComponent(cookiePair[1]);
        pref.setString('user_id', value).then((bool success) {
          if (success) {
            print('user_id is set');
          } else {
            print('Error');
          }
        });
      }
    }
  }
}
