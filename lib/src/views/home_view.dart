import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/post/post_bloc.dart';
import 'package:red_social/src/screens/screens.dart';
import 'package:red_social/src/widgets/widgets.dart';

class HomeView extends StatefulWidget {
const HomeView({ Key? key }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  bool showCreatePost = false;

  @override
  Widget build(BuildContext context){

    final postsBloc = BlocProvider.of<PostBloc>(context);

    return Scaffold(

      body: RefreshIndicator(
        onRefresh: () async {
          postsBloc.add( GetPostsEvent() );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
      
              Container(
                margin: const EdgeInsets.symmetric( vertical: 10, horizontal: 10 ),
                child: Row(
                  children: [
      
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.indigo,
                      child: Icon( Icons.person_2 ),
                    ),
      
                    const SizedBox(
                      width: 10,
                    ),
      
                    
                    Expanded(
                      child: GestureDetector(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular( 35 ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 15,
                               right: 15
                            ),
                            enabled: false,
                            hintText: '¿Qué estas pensando?'
                          ),
                        ),
                        onTap: (){
                          // showCreatePost = !showCreatePost;
                          // setState(() {});
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePostScreen()));
                        },
                      ),
                    ),
      
                    const SizedBox(
                      width: 10,
                    ),
      
                    IconButton(onPressed: (){}, icon: const Icon( Icons.photo ))
      
                  ],
                ),
              ),
      
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _NewHistoryCard(),
                    HistoryCard(),
                    HistoryCard(),
                    HistoryCard(),
                    HistoryCard(),
                    HistoryCard(),
                    HistoryCard(),
      
                  ],
                ),
              ),
      
      
              BlocBuilder<PostBloc,PostState>(
                builder: (_, state){
      
                  final posts = state.posts;
      
                  return Column(
                    children: [
      
                      ...posts.map((e) => PostCard( model: e, ) ).toList()
      
                    ],
                  );
                  
                }
              )
      
            ],
          ),
        ),
      )

    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all( 3 ),
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular( 15 )
      ),
      child: const Icon( Icons.photo ),
    );
  }
}

class _NewHistoryCard extends StatelessWidget {
const _NewHistoryCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
   return Container(
      margin: const EdgeInsets.all( 3 ),
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular( 15 )
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon( 
            Icons.add_a_photo_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}