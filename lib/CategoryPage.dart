import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_tanitim/ContentPage.dart';
import 'package:uni_tanitim/models/Content.dart';
import 'package:uni_tanitim/models/HomeCategoryContents.dart';

import 'FirebaseOperations.dart';

class CategoryPage extends StatefulWidget {


  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FirebaseOperations firebaseOperations = FirebaseOperations();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("KAMPÜS",style: TextStyle(fontSize: 24),),
        ),

        body: FutureBuilder(
          future: firebaseOperations.getPlaceUni(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Fakülteler",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Container(
                      height: 300,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          //for(var i in resimler())
                          for(var i in snapshot.data)
                            Fakuteler(i["categoryName"],i["description"],i["image"]),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15,bottom: 15),
                    child: Text("Diger",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container(
                    height: 300,
                    child:
                    Diger(),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        Content content = Content(content: "içerik 1",title: "başlık 1", image: "resim1");
                        Content content2 = Content(content: "içerik 2",title: "başlık 2", image: "resim2");
                        HomeCategoryContents homeCategoryContent = HomeCategoryContents(categoryName: "Mühendislik Fakültesi", contents: [content.toMap(),content2.toMap()], description: "Mühendislik Fakültesi Açıklama",
                            image: "https://firebasestorage.googleapis.com/v0/b/uni-project-f6db7.appspot.com/o/imgContentPage%2Fmuhendislik.jpg?alt=media&token=6c2c26b7-fcff-4b07-8606-e2039f3558e5", universityId: "msku");

                        firebaseOperations.addData(homeCategoryContent);
                      });
                    },
                    child: Text("EKLE"),
                  ),
                ],
              );
            }
            else{
              return Center();
            }
          },
        ),
      ),
    );

  }
}


class Fakuteler extends StatelessWidget {
  String title;
  String description;
  String image;

  Fakuteler(this.title,this.description,this.image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ContentPage()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // color: Colors.yellow,
            margin: EdgeInsets.all(8),
            width: 200,
            height: 300,
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
            margin: EdgeInsets.only(top: 200),
            height: 100,
            width: 100,
            // color: Colors.greenAccent,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25),
                  // color: Colors.pink,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text("KEŞFET"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Diger extends StatelessWidget {

  List<Color> colorList= [Color(0xffffe500),Color(0xffd60061),Color(0xff008feb),Color(0xffdbdbdb),Color(0xff00bb50),Color(0xffff8a00)];
  List<String> places= ["Yemekhane","Gençlik Merkezleri","Kütüphane","Kültür Merkezi","Kantinler","Diğer"];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: places.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio:1,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0

        ),
        itemBuilder: (context,indeks){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ContentPage()));
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 110,
                    decoration: BoxDecoration(
                      color: colorList[indeks],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Text(places[indeks],style: TextStyle(fontSize: 14,color: Colors.white)),
                ],
              ),
            ),
          );
        }
    );
  }
}