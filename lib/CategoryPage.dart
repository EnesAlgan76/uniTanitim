
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_tanitim/ContentPage.dart';

import 'FirebaseOperations.dart';
import 'models/Content.dart';
import 'models/HomeCategoryContents.dart';

class CategoryPage extends StatefulWidget {
  late String title;
  late String subtitle;
  CategoryPage({required this.title,required this.subtitle});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FirebaseOperations firestore = FirebaseOperations();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(widget.title,style: TextStyle(fontSize: 24),),
        ),

        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(widget.subtitle,style: TextStyle(fontSize: 18,color: Colors.white),),
            ),

            FutureBuilder(
                future: firestore.getPlaceUni(title : widget.title),
                builder: (context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Container(
                        height: 300,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            //for(var i in resimler())
                            for(var i in snapshot.data)
                              Fakuteler(i["categoryName"],i["description"],i["image"],i["contents"],i["galeriImage"]),
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return Center();
                  }
                }
            ),

            Padding(
              padding: EdgeInsets.only(left: 15,bottom: 15),
              child: Text("Diger",style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
            Container(
              height: 300,
              child:
              FutureBuilder(
                  future: firestore.getPlaceDiger(title: widget.title),
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      return Diger(snapshot.data);//diger kısmı eklemek için yapıldı
                    }else{
                      return Center();
                    }
                  }
              ),

            ),

          ],
        ),
      ),
    );

  }
}


class Fakuteler extends StatelessWidget {
  String title;
  String description;
  String image;
  List<dynamic> contents;
  List<dynamic> galeriImage;
  Fakuteler(this.title,this.description,this.image,this.contents,this.galeriImage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          // color: Colors.yellow,
          margin: EdgeInsets.all(8),
          width: 180,
          height: 270,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(image, fit: BoxFit.cover, color: Colors.white.withOpacity(0.5), colorBlendMode: BlendMode.modulate,),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 200,
                color: Color(0x6f000000),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:Text(title,style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                )
            ),
            Container(
                width: 200,
                color: Color(0x6f000000),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:Text(description,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center,),
                )
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 240),
          height: 100,
          width: 130,
          // color: Colors.greenAccent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                // color: Colors.pink,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContentPage(contents: contents,coverImage: image,
                      categoryName: title, galeriImage: galeriImage,)));
                  },
                  child: Text("KEŞFET",style: TextStyle(fontFamily: 'Quicksand'),),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0x954800B1)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Diger extends StatelessWidget {
  List<Color> colorList= [Color(0xffffe500),Color(0xffd60061),Color(0xff008feb),Color(0xffdbdbdb),Color(0xff00bb50),Color(0xffff8a00)];
  List<String> places= ["Yemekhane","Gençlik Merkezleri","Kütüphane","Kültür Merkezi","Kantinler","Diğer"];
  List assetImages = ["yemekhane2.png","genclikMerkezi.png","kutuphane.png",
    "kulturMerkezi.png","kantin.png","diger.png"]; //kampüs sayfasınde diger kısım eklenirken kullanıldı


  late List digerList;

  Diger(this.digerList);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: digerList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio:1,

        ),
        itemBuilder: (context,indeks){
          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContentPage(contents: digerList[indeks]["contents"],
                    coverImage: digerList[indeks]["image"], categoryName: digerList[indeks]["title"], galeriImage: digerList[indeks]["galeriImage"],)));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: colorList[indeks],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Container(
                        height: 70,
                        width: 70,
                        child:
                        digerList[indeks]["title"] =="Kampüs" ?
                        Image.asset(assetImages[indeks],fit: BoxFit.cover,)
                            :
                        Image.asset("placeholder.png",fit: BoxFit.cover,)

                    ),
                  ],
                ),
              ),
              Text(digerList[indeks]["categoryName"],style: TextStyle(fontSize: 14,color: Colors.white),),
            ],
          );
        }
    );
  }
}

