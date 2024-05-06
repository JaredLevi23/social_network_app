import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/post/post_bloc.dart';
import 'package:red_social/src/services/posts_service.dart';
import 'package:red_social/src/ui/input_decorations.dart';
import 'package:red_social/src/utils/image_utils.dart';
import 'package:red_social/src/widgets/widgets.dart';

class CreatePostScreen extends StatefulWidget {
const CreatePostScreen({ Key? key }) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  late PostModel postModel;
  bool isEditing = false;

  @override
  void initState() {

    final user = FirebaseAuth.instance.currentUser!;

    postModel = PostModel(
      content: '', 
      date: DateTime.now(),
      imgs: [],
      reactions: [],
      title: '', 
      userId: user.uid,
      userName: user.displayName != null ? user.displayName!.isEmpty ? user.email! : user.displayName! : user.email!, 
      uid: '',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context){

    final postsBloc = BlocProvider.of<PostBloc>(context);

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon( Icons.add ),
        onPressed: (){
          showModalBottomSheet(context: context, builder: (_){
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      outlineColor: Colors.indigo,
                      fontColor: Colors.white,
                      label: 'Tomar foto',
                      onPressed: () async {
                        final img = await ImageUtils.pickImageWithCamera();
      
                        if( img != null ){
                          postModel.imgs.add( ImgModel(description: '', img: img.path, reactions: 0) );
                          setState(() {});
                        }
                      },
                    ),
                  ),
      
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      outlineColor: Colors.indigo,
                      fontColor: Colors.white,
                      label: 'Cargar de galeria',
                      onPressed: () async {
                        final images = await ImageUtils.pickMultiImage();
      
                        if( images.isNotEmpty ){
                          for (var element in images) {
                            postModel.imgs.add( ImgModel(description: '', img: element.path, reactions: 0) );
                          }
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),

      appBar: AppBar(
        title: const Text('Postear'),
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon( Icons.close )
        ),
        actions: [
          TextButton(
            onPressed: (){
              postsBloc.add( SubmitPostEvent(postModel: postModel) );
            }, 
            child: const Text('Publicar', style: TextStyle( color: Colors.white ),)
          )
        ],
      ),

      body: SingleChildScrollView(
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {

            switch ( state.status ) {
              case TypeState.initial:
                break;
              case TypeState.loaded:
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text( state.message )) );
                postsBloc.add( ResetMessageEvent() );
                Navigator.pop(context);
                break;
              case TypeState.loading:
                break;
              case TypeState.error:
                break;
            }
            
            if( state.message.isNotEmpty ){
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text( state.message )) );
            }

          },
          child: Column(
            children: [
  
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecorations.textFormFieldDecoration('¿Qué estás pensando?'),
                  maxLines: 8,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                  onChanged: ( value ){
                    postModel.content = value;
                  },
                ),
              ),
  
              ...postModel.imgs.map((e){
  
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular( 15 )
                  ),
                margin: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only( topLeft: Radius.circular( 15 ), topRight: Radius.circular( 15 ) ),
                          child: Image.file( File( e.img ), fit: BoxFit.scaleDown  )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isEditing 
                          ? TextFormField(
                            decoration: InputDecorations.textFormFieldDecoration('Descripción'),
                            onChanged: ( value ){
                              e.description = value;
                            },
                          )
                          : GestureDetector(
                            onTap: () => setState(() {
                              isEditing =  !isEditing;
                            }),
                            child: Text( 
                              e.description.isEmpty 
                              ? 'Agregar descripción' 
                              : e.description  
                            )
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
  
                    IconButton(onPressed: () => setState(() {
                      isEditing =  !isEditing;
                    }), icon: Icon( isEditing ? Icons.done : Icons.edit  ))
                  ],
                ),
              );
              } ).toList(),  
            ],
          ),
        ),
      ),
    );
  }
}