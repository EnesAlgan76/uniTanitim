import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:uni_tanitim/AddingPage.dart';
import 'package:uni_tanitim/CommentsPage.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';
import 'package:uni_tanitim/ImagesViewPage.dart';
import 'package:uni_tanitim/VideosViewPage.dart';
import 'package:uni_tanitim/widgets/contentWidget.dart';
import 'package:uni_tanitim/widgets/linkWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GetxControllerClass.dart';
import 'models/Category.dart';

final liste = [];


class ContentPage extends StatelessWidget {
  Category category;

  ContentPage({required this.category}) ;


  FirebaseOperations firebaseOperations = FirebaseOperations();
  GetxControllerClass getxController = Get.put(GetxControllerClass());


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.black87,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Flexible(child: Text(category.categoryName, style: TextStyle(color: Colors.white, fontSize: 17),overflow: TextOverflow.fade,)),

                Container(
                  margin: EdgeInsets.only(top: 7,bottom: 7,left: 15),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 1.5), borderRadius: BorderRadius.circular(12)) ,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      Get.to(AddingPage(categoryId: category.categoryId, whichCategory: category.categoryName));
                    },
                    child: Row(
                      children: [
                        Text("Ekleme Yap ",style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                        Icon(Icons.add, color: Colors.white,)
                      ],
                    ),
                  ) ,
                ),

              ],
            ),
          )
      ),
      backgroundColor: Color(0xffececec),
      body: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    height:250,
                    width: width,
                    child:Image.network(category.coverImage,fit: BoxFit.cover,)),
                Row(
                  children: [
                    Flexible(child: GestureDetector(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideosViewPage(videos :category.videos)));
                      },
                      child: Container(
                        height: 45,
                        color: Color(0x88cb0000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Videolar",style: TextStyle(fontSize: 17, decoration: TextDecoration.none, color: Colors.white)),
                            Icon(Icons.videocam_outlined,size: 25,)],),
                      ),
                    )
                    ),
                    Flexible(child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewPage(galeriImage: category.galleryImages,)));
                      },
                      child: Container(
                        height: 45,
                        color: Color(0x88cbb000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Resimler",style: TextStyle(fontSize: 17, decoration: TextDecoration.none, color: Colors.white)),
                            Icon(Icons.photo_camera_outlined,size: 25,)],),
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),


            for(var content in category.contents)
              showContent(content)
          ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await getxController.getCommentsGetX(placeId: category.categoryId);
          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage(placeId: category.categoryId,)));

          // Comment comment =Comment(comment: "Mühendis Yorum2", title: "Mühhhh", date: currentTime, likes: 0, placeId: categoryId);
          // firebaseOperations.addComments(comment: comment);
          // firebaseOperations.addComments2(comment);
        },
        child: Icon(Icons.comment),
      ),
    );
  }



  Widget showContent(Map content){
    if(content["title"] !="link"){
      return  ContentWidget(content: content["content"],
          imageLink: content["image"] ,
          title: content["title"],);

    }else{
      return LinkWidget(link: content["content"], imageLink: content["image"]);
    }
  }
}
