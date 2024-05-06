import 'package:flutter/material.dart';
import 'package:red_social/src/blocs/comments/commets_bloc.dart';
import 'package:red_social/src/screens/messages_screen.dart';
import 'package:red_social/src/views/views.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/view/view_cubit.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _CurrentView(),
        actions: [
          BlocBuilder<ViewCubit, int>(
            builder: (context, state) {
              if (state == 4) {
                return IconButton(
                    onPressed: () {}, icon: const Icon(Icons.settings));
              }

              return const SizedBox();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MessagesScreen()));
            },
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          final viewCubit = BlocProvider.of<ViewCubit>(context, listen: false);
          viewCubit.changeCurrentView(value);
        },
        children: const [
          HomeView(),
          RequestsView(),
          MovieView(),
          NotificationsView(),
          MenuView()
        ],
      ),
      bottomNavigationBar: BlocBuilder<CommetsBloc, CommetsState>(
        builder: (context, state) {

          final showNavigationBar = state.openComents;

          if( showNavigationBar ){
            return const SizedBox();
          }

          return CustomBottomNavigationBar(
            controller: _controller,
          );
        },
      ),
    );
  }
}

class _CurrentView extends StatelessWidget {
  const _CurrentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewCubit, int>(
      builder: (context, state) {
        switch (state) {
          case 0:
            return const Text('Inicio');
          case 1:
            return const Text('Solicitudes');
          case 2:
            return const Text('Videos');
          case 3:
            return const Text('Notificaciones');
          case 4:
            return const Text('Menú');
          default:
            return const Text('X');
        }
      },
    );
  }
}
