

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsService{

  final _firebase = FirebaseFirestore.instance;

  Future<List> getPosts( String postId )async{
    final data = await _firebase.collection("comments").where( "post", isEqualTo: postId ).get();
    try {
      final comments = data.docs;

      return comments.isEmpty
      ? []
      : comments.map((e){
        print( e.data().toString() );
        return e.data();
      }).toList();
      
    } catch (e) {
      print( e );
      return [];
    }
  }

}

/*

{
  comments: [
    {e
      "date": "Timestamp(
        seconds=1690737779, 
        nanoseconds=241000000
    )", 
    "imgs": [
      "https://www.sfu.ca/imgs2015/van.jpg"
    ], 
    "comment": "Este es un comentario"
    }
  ], 
  "post": "O2G8fs5MJ2Q8QPdI9ZUn"
}

*/