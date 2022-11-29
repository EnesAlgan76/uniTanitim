
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getUserImages() async{
  var settings = await SharedPreferences.getInstance();
  List<String> value =await settings.getStringList("userImages")??[];
  return value;
}

Future<void> setUserImages(List<String> value) async{
  var settings = await SharedPreferences.getInstance();
  await settings.setStringList("userImages", value);
}