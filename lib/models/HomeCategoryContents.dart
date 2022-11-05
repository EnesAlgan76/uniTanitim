import 'package:uni_tanitim/models/Content.dart';

class HomeCategoryContents{
  String categoryName;
  List<Map<String,dynamic>> contents;
  String description;
  String image;
  String universityId;

  HomeCategoryContents({required this.categoryName, required this.contents,
    required this.description,required this.image,required this.universityId});

  Map<String, dynamic> toMap() {
    return {
      'categoryName': this.categoryName,
      'contents': this.contents,
      'description': this.description,
      'image': this.image,
      'universityId': this.universityId,
    };
  }

  factory HomeCategoryContents.fromMap(Map<String, dynamic> map) {
    return HomeCategoryContents(
      categoryName: map['categoryName'] as String,
      contents: map['contents'] as List<Map<String, dynamic>>,
      description: map['description'] as String,
      image: map['image'] as String,
      universityId: map['universityId'] as String,
    );
  }
}

