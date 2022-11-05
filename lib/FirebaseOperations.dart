import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_tanitim/models/InitCategory.dart';

import 'models/Content.dart';
import 'models/HomeCategoryContents.dart';

class FirebaseOperations{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPlaceUni() async{
    var placeDocuments =await firestore.collection("homeCategoryContent").get();
    return placeDocuments.docs;
  }


  Future<void> addData(HomeCategoryContents homeCategoryContents) async{
    await firestore.collection("homeCategoryContent").add(homeCategoryContents.toMap());
  }


  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getHomeCategories()async{
    var userDocument = await firestore.collection("homeCategories").get();
    print("--------------------------------- ${userDocument.docs[0]["title"]}");

    return userDocument.docs;
  }

  Future<void> insertCategory({required String title, required String description, required String image}) async{
    InitCategory category = InitCategory(title: title, description: description, image: image);
    await firestore.collection("homeCategories").add(category.toMap());
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getContents()async{
    var contentMap = await firestore.collection("initCategoriesContent").get();
    print("--------------------------------- ${contentMap}");

    return contentMap.docs;
  }


}