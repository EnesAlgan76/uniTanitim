import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';

import 'SharedPreferencesOperations.dart';

class GetxControllerClass extends GetxController{

  var userImages= [].obs;
  var places = [].obs;


  @override
  void onInit() async{
    List images = await getUserImages();
    userImages.value = images;
    print("************* GET INIT WORKED ************");
    super.onInit();
  }

  Future<void> getData(String title)async{
    places.value = await FirebaseOperations().getPlaceUni(title: title);
  }



}