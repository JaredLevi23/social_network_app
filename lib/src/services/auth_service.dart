
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final _firebaseAuth = FirebaseAuth.instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<AuthResponseModel> createUserWithEmailAndPassword({ required String email, required String password }) async {
    try {
    
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      if( userCredential.user != null ){
        return AuthResponseModel(
          userCredential: userCredential,
          message: 'Cuenta creada.'
        );
      }

      return AuthResponseModel(
        message: 'Verifique sus datos por favor.'
      );

    } on FirebaseAuthException catch (e) {
     return AuthResponseModel(
        message: e.message
      );
    } catch(_){
      return AuthResponseModel(
        message: 'Intentelo más tarde.'
      );
    }
  }

  Future<AuthResponseModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleAuth = await account?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResponseModel(
        userCredential: userCredential
      );
    } catch (e) {
      return AuthResponseModel(
        message: e.toString(),
        userCredential: null
      );
    }
  }

  Future<AuthResponseModel> loginWithEmailAndPassword({ required String email, required String password }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if(  userCredential.user != null ){
        return AuthResponseModel(
          userCredential: userCredential
        );
      }

      return AuthResponseModel(
        message: 'Verifica tu correo y/o contraseña.',
        userCredential: null
      );

    } on FirebaseAuthException catch (e) {
      return AuthResponseModel(
        message: e.message,
        userCredential: null
      );
    } catch( _ ){
      return AuthResponseModel(
        message: 'Intentalo más tarde',
        userCredential: null
      );
    }
  }

  Future<void> restoreAccoutnWithEmail({ required String email }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print( e );
    }
  }

}

class AuthResponseModel{

  String? message;
  UserCredential? userCredential;

  AuthResponseModel({
    this.userCredential,
    this.message

  });
}