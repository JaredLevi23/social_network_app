import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/auth/auth_bloc.dart';
import 'package:red_social/src/blocs/comments/commets_bloc.dart';
import 'package:red_social/src/blocs/post/post_bloc.dart';
import 'package:red_social/src/blocs/users/users_bloc.dart';
import 'package:red_social/src/blocs/view/view_cubit.dart';
import 'package:red_social/src/screens/screens.dart';
import 'package:red_social/src/services/auth_service.dart';
import 'package:red_social/src/services/cloudinary_service.dart';
import 'package:red_social/src/services/comments_service.dart';
import 'package:red_social/src/services/posts_service.dart';
import 'package:red_social/src/services/users_service.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainBloc());
}

class MainBloc extends StatelessWidget {
const MainBloc({ super.key });

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ViewCubit()),
        BlocProvider(create: (_) => AuthBloc( authService: AuthService() )),
        BlocProvider(create: (_) => PostBloc(postsService: PostsService(), cloudinaryService: CloudinaryService())),
        BlocProvider(create: (_) => CommetsBloc( commentsService: CommentsService() )),
        BlocProvider(create: (_) => UsersBloc(postsService: PostsService(), usersService: UsersService()))
      ],
      child: const Main(),
    );
  }
}

class Main extends StatelessWidget {
const Main({ super.key });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CheckAuthScreen(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade300,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.indigo
        )
      ),
    );
  }
}