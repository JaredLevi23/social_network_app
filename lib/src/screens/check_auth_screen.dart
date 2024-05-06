import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:red_social/src/screens/screens.dart';

class CheckAuthScreen extends StatefulWidget {
const CheckAuthScreen({ Key? key }) : super(key: key);

  @override
  State<CheckAuthScreen> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen> {

  @override
  void initState() {
    
    SchedulerBinding.instance.addPostFrameCallback((_) { 
      final user = FirebaseAuth.instance.currentUser;

      if( user != null ){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(
        child: Text('Verificando cuenta...'),
      ),
    );
  }
}