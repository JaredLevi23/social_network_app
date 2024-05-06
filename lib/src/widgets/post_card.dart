import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/comments/commets_bloc.dart';
import 'package:red_social/src/blocs/post/post_bloc.dart';
import 'package:red_social/src/screens/post_details_screen.dart';
import 'package:red_social/src/screens/screens.dart';
import 'package:red_social/src/services/posts_service.dart';

class PostCard extends StatefulWidget {

  final PostModel model;

  const PostCard({
    super.key,
    required this.model
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  int index = 1;
  bool reaction = false;
  final id = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) { 
      reaction = widget.model.reactions.contains( id );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Icon( Icons.person_2, color: Colors.white, ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( widget.model.userName ),
                          Text( widget.model.date.toString().split('.')[0], style: const TextStyle( fontSize: 13 ), ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      
              IconButton(
                icon: const Icon( Icons.more_horiz ),
                onPressed: (){
                  showModalBottomSheet(context: context, builder: (_){
                    return SingleChildScrollView(
                      child: Column(
                        children: [

                          ListTile(
                            title: const Text(''),
                            onTap: (){
                            },
                          ),

                          ListTile(
                            leading: const Icon( Icons.save ),
                            title: const Text(''),
                            onTap: (){
                            },
                          ),

                          ListTile(
                            leading: const Icon( Icons.save ),
                            title: const Text('Guardar'),
                            onTap: (){
                            },
                          ),

                        ],
                      ),
                    );
                  });
                }, 
              ),
      
            ],
          ),

          const SizedBox(
            height: 8
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model.content,
              style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w300 ),
              textAlign: TextAlign.start,
            ),
          ),

          if( widget.model.imgs.isNotEmpty )
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
                  ...widget.model.imgs.map((e) => Column(
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
                    imgs: widget.model.imgs,
                    title: widget.model.title,
                    content: widget.model.content,
                  ),
                  transitionDuration: const Duration( milliseconds: 300 ),
                  transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c,)
                )
              );
            },
          ),

          Column(
            children: [

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${ widget.model.reactions.length } reacciones'),
                    Row(
                      children: [
                        widget.model.imgs.isEmpty 
                        ? const SizedBox()
                        : Text( '$index/${ widget.model.imgs.length }' ),
                        widget.model.imgs.isEmpty 
                        ? const Icon( Icons.image_not_supported )
                        : const Icon( Icons.photo )
                      ],
                    )
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  TextButton.icon(
                    icon: Icon( reaction ? Icons.favorite : Icons.favorite_border  ), label: const Text('Reaccionar'),
                    onPressed: (){

                      final postBloc = BlocProvider.of<PostBloc>(context, listen: false);
                      reaction = !reaction;

                      if( reaction ){
                        // agregar a la lista
                        widget.model.reactions.add( id );
                      }else{
                        // quitar de la lista
                        widget.model.reactions.remove( id );
                      }

                      postBloc.add( ReactionPostEvent(postModel: widget.model ));
                      
                      setState(() {});
                    }, 
                  ),

                  TextButton.icon(
                    label: const Text('Comentar'),
                    icon: const Icon( Icons.comment ), 
                    onPressed: (){
                      final commentsBloc = BlocProvider.of<CommetsBloc>(context, listen: false);
                      commentsBloc.add( LoadCommentsEvent( widget.model ) );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostDetailsScreen()
                        )
                      );
                    }, 
                  ),

                  TextButton.icon(
                    label: const Text('Compartir'),
                    icon: const Icon( Icons.share ), 
                    onPressed: (){

                    }, 
                  ),

                ],
              )

            ],
          )
      
        ],
      ),
    );
  }
}