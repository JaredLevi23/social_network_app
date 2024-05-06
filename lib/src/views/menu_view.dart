import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/users/users_bloc.dart';
import 'package:red_social/src/blocs/view/view_cubit.dart';
import 'package:red_social/src/widgets/widgets.dart';

import '../screens/screens.dart';

class MenuView extends StatelessWidget {
const MenuView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final user = FirebaseAuth.instance.currentUser;
    final userBloc = BlocProvider.of<UsersBloc>(context);

    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
        child: Column(
          children: [

            Row(
              children: [

                const CircleAvatar(
                  child: Icon( Icons.person_2 ),
                ),
                
                const SizedBox(
                  width: 10,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user?.email}'),
                    LabelTap(label: 'Ver mi perfil', onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen() ));
                    })
                  ],
                ),
              ],
            ),

            const Divider(),

            ListTile(
              title: const Text('Información Personal'),
              leading: const Icon( Icons.account_box ),
              onTap: (){ 
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BasicInfoScreen()));
              },
            ),

            ListTile(
              title: const Text('Lista de amigos'),
              leading: const Icon( Icons.group ),
              onTap: (){},
            ),

            ListTile(
              title: const Text('Cerrar sesión'),
              leading: const Icon( Icons.logout ),
              onTap: () {
                final viewCubit = BlocProvider.of<ViewCubit>(context, listen: false);
                FirebaseAuth.instance.signOut();
                viewCubit.changeCurrentView(0);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
              }
            ),



          ],
        ),
      ),

    );
  }
}