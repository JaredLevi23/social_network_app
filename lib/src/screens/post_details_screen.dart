import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/comments/commets_bloc.dart';
import 'package:red_social/src/screens/gallery_screen.dart';
import 'package:red_social/src/ui/input_decorations.dart';
import 'package:red_social/src/utils/image_utils.dart';
import 'package:red_social/src/widgets/widgets.dart';

class PostDetailsScreen extends StatefulWidget {
const PostDetailsScreen({ Key? key }) : super(key: key);

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {

  int index = 0;
  
  @override
  Widget build(BuildContext context){

    final commetsBloc = BlocProvider.of<CommetsBloc>(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [

              const Text('Comentarios'),

              BlocBuilder<CommetsBloc, CommetsState>(
                builder: (context, state) {

                  if( state.isLoading ){
                    return const LinearProgressIndicator();
                  }

                  if( state.comments.isEmpty ){
                    return const Expanded(
                      child: Center(
                        child: Text('No hay comentarios en este post'),
                      ),
                    );
                  }

                  //final comments = state.comments;

                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          commetsBloc.model?.content ?? '',
                          style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w300 ),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      GestureDetector(
                        child: SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: PageView(
                            onPageChanged: ( value ){
                              setState(() {
                                index = value+1;
                              });
                            },
                            children: [
                              ...commetsBloc.model!.imgs.map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: ClipRRect(
                                        child: Image(
                                          image: NetworkImage( e.img ),
                                        )
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8
                                    ),
                                    child: Text( 
                                      e.description,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                  )
                                ],
                              )).toList()
                            ],
                          )
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => GalleryScreen(
                                imgs: commetsBloc.model?.imgs ?? [],
                                title: commetsBloc.model?.title ?? '',
                                content: commetsBloc.model?.content ?? '',
                              ),
                              transitionDuration: const Duration( milliseconds: 300 ),
                              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c,)
                            )
                          );
                        },
                      ),

                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.comments.length,
                          itemBuilder: (_, index){

                            //final comment = comments[index];

                            return ListTile(
                              title: Text('Comentario $index'),
                              subtitle: const Text( 'Comment'  ),
                            );
                        })
                      ),
                    ],
                  );
                },
              ),
    
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecorations.textFormFieldDecoration('Agrega un comentario :D'),
                      ),
                    ),
                  ),

                  
                  IconButton(
                    icon: const Icon( Icons.attach_file ),
                    onPressed: (){
                      
                      showModalBottomSheet(context: context, builder: (_){
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                        
                              ListTile(
                                title:  const Text('Tomar foto'),
                                leading: const Icon( Icons.camera_alt_outlined ),
                                onTap: () async {
                                  final img = await ImageUtils.pickImageWithCamera();
                                  if( img != null ){
                                    //TODO: Agregar imagen a algun lugar xD 
                                  }
                                },
                              ),
                        
                              ListTile(
                                title: const Text('Tomar de galeria'),
                                leading: const Icon( Icons.photo_library_rounded ),
                                onTap: () async {
                                  final img = await ImageUtils.pickImageFromGallery();
                                  if( img != null ){
                                    //TODO: Agregar imagen a algun lado :$ 
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      });

                    }, 
                  ),
                  IconButton(onPressed: (){}, icon: const Icon( Icons.send )),
                ],
              )
            ],
          ),
    
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon( Icons.close ),
              onPressed: (){
                
                Navigator.pop(context);
              }, 
            )
          )
        ]
      ),
    );
  }
}