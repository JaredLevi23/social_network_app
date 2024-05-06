import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:red_social/src/ui/input_decorations.dart';
import 'package:red_social/src/utils/image_utils.dart';
import 'package:red_social/src/widgets/widgets.dart';

import '../blocs/users/users_bloc.dart';

class BasicInfoScreen extends StatefulWidget {
const BasicInfoScreen({ Key? key }) : super(key: key);

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {

  String path = '';
  String backgroundImg = '';
  List<Color> gradientProfile = [];
  List<Color> gradientBackground = [];

  @override
  void initState() {
    
    SchedulerBinding.instance.addPostFrameCallback((_) async {

      final usersBloc = BlocProvider.of<UsersBloc>(context, listen: false);
      final uid = FirebaseAuth.instance.currentUser!.uid;
      usersBloc.add( SelectedUserEvent(uid: uid));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    final userBloc = BlocProvider.of<UsersBloc>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('Información básica'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: gradientBackground.isNotEmpty && gradientBackground.length>=2 
        //     ? gradientBackground
        //     : [
        //       Colors.white,
        //       Colors.white
        //     ]
        //   )
        // ),
        child: SingleChildScrollView(
          child: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {

              final data = state.users;
              //final user = data.user;

              return Column(
                children: [
                  
                  Stack(
                    children: [
                  
                      // Center(
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: MediaQuery.of(context).size.width * 0.6,                   
                      //     child: _ImageView(path: user.photoPresent),
                      //   ),
                      // ),
                  
                      // Center(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 0.5,
                      //     height: MediaQuery.of(context).size.width * 0.5,
                      //     decoration: const BoxDecoration(
                      //       color: Colors.indigo,
                      //       shape: BoxShape.circle
                      //     ),
                      //     child: _ImageView(path: user.photoUrl),
                      //   ),
                      // ),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {

                              final img = await ImageUtils.pickImageFromGallery();

                              if( img != null ){
                                path = img.path;
                                final gradients = await PaletteGenerator.fromImageProvider( FileImage( File( path ) ),maximumColorCount: 3 );
                                gradientProfile = gradients.colors.toList();
                                setState(() {});
                              }
                            }, 
                            icon: const Icon( Icons.photo )
                          ),
                  
                          IconButton(
                            onPressed: () async {
                              
                              final img = await ImageUtils.pickImageWithCamera();

                              if( img != null ){
                                path = img.path;
                                
                                final gradients = await PaletteGenerator.fromImageProvider( FileImage( File( path ) ),maximumColorCount: 3 );
                                gradientProfile = gradients.colors.toList();
                                setState(() {});
                              }
                            }, 
                            icon: const Icon( Icons.photo_camera )
                          ),
                        ],
                      ),
                  
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {

                              final img = await ImageUtils.pickImageFromGallery();

                              if( img != null ){
                                backgroundImg = img.path;
                                final gradients = await PaletteGenerator.fromImageProvider( FileImage( File( backgroundImg ) ), maximumColorCount: 3 );
                                gradientBackground = gradients.colors.toList();
                                setState(() {});
                              }
                            }, 
                            icon: const Icon( Icons.photo )
                          ),
                  
                          IconButton(
                            onPressed: () async {
                              final img = await ImageUtils.pickImageWithCamera();
                              if( img != null ){
                                backgroundImg = img.path;
                                final gradients = await PaletteGenerator.fromImageProvider( FileImage( File( backgroundImg ) ), maximumColorCount: 3 );
                                gradientBackground = gradients.colors.toList();
                                setState(() {});
                              }
                            }, 
                            icon: const Icon( Icons.photo_camera )
                          ),
                        ],
                      )
                    ],
                  ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  
                  TextFormField(
                    decoration: InputDecorations.textFormFieldDecoration('Nombre(s)'),
                    onChanged: ( value ){
                      
                    },
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  
                  TextFormField(
                    decoration: InputDecorations.textFormFieldDecoration('Apellido(s)'),
                    onChanged: ( value ){
                    },
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  
                  TextFormField(
                    decoration: InputDecorations.textFormFieldDecoration('Cumpleaños'),
                    onChanged: ( value ){
                    },
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  
                  TextFormField(
                    decoration: InputDecorations.textFormFieldDecoration('Género'),
                    onChanged: ( value ){
                      
                    },
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  
                  CustomButton(
                    label: 'Guardar',
                    onPressed: (){
                      
                    },
                  )
                  
                ],
              );
            },
          ),
        ),
      ),

    );
  }
}


class _ImageView extends StatelessWidget {

  final String path;
  const _ImageView({ Key? key, required this.path }) : super(key: key);

  @override
  Widget build(BuildContext context){
    try {

      if( path.isEmpty ){
        return const Icon( Icons.person_2, size: 50, color: Colors.white, );
      }

      if( path.startsWith('http') ){
        return ClipRRect(
          borderRadius: BorderRadius.circular( 100 ),
          child: CachedNetworkImage(
            imageUrl: path,
            progressIndicatorBuilder: (_,__,___) => const CircularProgressIndicator(),
            errorWidget: (_,__,___) => const Icon( Icons.signal_wifi_connected_no_internet_4_sharp ),
            placeholder: (_, __) => const CircularProgressIndicator(),
          ),
        ); 
      }

      if( path.isNotEmpty ){
        return ClipRRect(
          borderRadius: BorderRadius.circular( 100 ),
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
          ),
        );
      }

      return const Icon( Icons.person_2 );

    } catch (e) {
      return const Icon( Icons.person_2 );
    }
  }
}