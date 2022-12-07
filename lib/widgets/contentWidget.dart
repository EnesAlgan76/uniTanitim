import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentWidget extends StatelessWidget {
  String? title;
  String content;
  String? imageLink;
  double titleFontSize;

  ContentWidget({this.title, required this.content, this.imageLink, this.titleFontSize=18});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 12,bottom: 12),
      child: Column(
        children: [
            title!=""? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(title!, style: TextStyle(fontSize: titleFontSize,  decoration: TextDecoration.none, color: Colors.black)),
                  ),
                ),
              ],
            ):SizedBox(),
            content!=""?Text(content, style: TextStyle(fontSize: 16,color: Colors.black87,  decoration: TextDecoration.none)): SizedBox(),
            if(imageLink!="")
            Image.network(imageLink!)
        ],
      ),
    );
  }
}
