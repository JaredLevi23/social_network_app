

import 'package:cloud_firestore/cloud_firestore.dart';

class PostsService{

  final _firebase = FirebaseFirestore.instance;

  Future<String> createPost({ required PostModel postModel }) async {
    final post = await _firebase.collection("posts").add( postModel.toJson() );
    return post.id;
  }

  Future<List<PostModel>> getPosts()async{
    final data = await _firebase.collection("posts").get();
    try {
      return data.docs.map(( doc ) => PostModel.fromJson( {...doc.data(), "uid": doc.id } ) ).toList();
    } catch (e) {
      print( e );
      return [];
    }
  }

  Future<List<PostModel>> getPostsByUserId({ required String uid })async{
    final data = await _firebase.collection("posts").where("userId", isEqualTo: uid).get();
    try {
      return data.docs.map(( doc ) => PostModel.fromJson( {...doc.data(), "uid": doc.id } ) ).toList();
    } catch (e) {
      print( e );
      return [];
    }
  }

  Future<void> reactionToPost( { required PostModel postModel, required String userId } ) async {
    final post = _firebase.collection("posts").doc( postModel.uid );
    post.update( { "reactions": postModel.reactions } );

  }

  Future<void> updatePost({ required PostModel postModel } ) async {
    final post = _firebase.collection("posts").doc( postModel.uid );
    post.update( postModel.toJson() ).then((value){
      print('Documento actualizado');
    },onError: ( error ) => print );
  }

  Future<void> deletePost({ required PostModel postModel }) async {
    _firebase.collection("posts").doc( postModel.uid ).delete().then((value){
      print( 'Documento eliminado' );
    }, onError: (error) => print );
  }
}


class PostModel{
  
  String uid;
  String title;
  String userId;
  String userName;
  DateTime date;
  String content;
  List<ImgModel> imgs;
  List reactions;

  PostModel({
    required this.uid,
    required this.title,
    required this.content,
    required this.userId,
    required this.userName,
    required this.date,
    required this.imgs,
    required this.reactions,
  });

  factory PostModel.fromJson( Map<String,dynamic> json ){
    return PostModel(
      uid: json["uid"],
      title: json["title"], 
      content: json["content"], 
      userId: json["userId"], 
      imgs: List<ImgModel>.from( json["imgs"].map( (x) => ImgModel.fromJson( x ) ) ).toList() , 
      reactions: json["reactions"],
      date: DateTime.fromMillisecondsSinceEpoch( json["date"] ),
      userName: json["username"]
    );
  }

  Map<String, dynamic> toJson() => {
    "username": userName,
    "title":title,
    "content":content,
    "userId":userId,
    "date": date.millisecondsSinceEpoch,
    "imgs": imgs.map((e) => e.toJson()).toList(),
    "reactions":reactions,
  };
  
}

class ImgModel{

  String description;
  String img;
  int reactions;

  ImgModel({
    required this.description,
    required this.img,
    required this.reactions
  });


  factory ImgModel.fromJson( Map<String,dynamic> json ) => 
    ImgModel(
      description: json["description"], 
      img: json["img"], 
      reactions: json["reactions"]
    );

  Map<String, dynamic> toJson() => {
    "description": description,
    "img": img,
    "reactions": reactions
  };



}