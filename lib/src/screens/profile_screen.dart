import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text('Mi perfil'),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.indigo,
                  child: const Center(
                    child: Icon( Icons.photo, color: Colors.white ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only( left: 10 ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.deepPurple,
                      child: Icon( Icons.person, size: 50 ),
                    ),
                  )
                ),
              ],
            ),


            Container(
              padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 10 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? 'Sin nombre',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),
                  ),

                  Text(
                    user?.email ?? 'Correo electrónico desconocido.',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ],
              ),
            ),


            

          ],
        ),
      ),

    );
  }
}