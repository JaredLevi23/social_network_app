import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UsersService{

  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<String> saveUserInfo({ required UserModel userModel }) async {
    try {
      await _firebase.collection("users").doc( userModel.uid ).set( userModel.toJson() );
      return 'Información actualizada';
    } catch (e) {
      return 'No se guardaron los cambios';
    }
  }

  Future<UserModel?> getUserInfo({ required String uid  }) async {
    final doc = await _firebase.collection("users").doc( uid ).get();
    try {
      return UserModel.fromJson( doc.data()! );
    } catch (e) {
      return null;
    }
  }

  Future<List<UserModel>> getUsers()async{
    final data = await _firebase.collection("users").get();
    try {
      return data.docs.map(( doc ) => UserModel.fromJson( {...doc.data(), "uid": doc.id } ) ).toList();
    } catch (e) {
      print( e );
      return [];
    }
  }

  Future<void> sendRequest({ required String uid, required UserModel myProfile }) async {
    final ref = _database.ref("requests/$uid");
    await ref.set(
      myProfile.toSendRequestJson()
    );
  }
}

class UserModel {

  final String uid;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String photoPresent;
  final String gender;
  final DateTime birthday;

  UserModel({
    required this.uid, 
    required this.firstName, 
    required this.lastName, 
    required this.gender, 
    required this.birthday,
    this.photoUrl = '',
    this.photoPresent = ''
  });

  factory UserModel.fromJson( Map<String, dynamic> json ){
    return UserModel(
      uid: json["uid"], 
      firstName: json["firstName"], 
      lastName: json["lastName"], 
      gender: json["gender"], 
      birthday: json["birthday"],
      photoUrl: json["photoUrl"],
      photoPresent: json["photoPresent"]
    );
  }

  Map<String,dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "birthday": birthday,
    "photoUrl": photoUrl,
    "photoPresent": photoPresent
  };

  Map<String,dynamic> toSendRequestJson() => {
    "uid": uid,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "birthday": birthday,
    "photoUrl": photoUrl,
    "photoPresent": photoPresent
  };

}
