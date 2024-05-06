import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/view/view_cubit.dart';


class CustomBottomNavigationBar extends StatelessWidget {

  final PageController controller;

  const CustomBottomNavigationBar({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    final viewCubit = BlocProvider.of<ViewCubit>(context);
    
    return BottomNavigationBar(
      currentIndex: context.watch<ViewCubit>().state,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.indigo,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group), 
          label: 'Solicitudes'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tv), 
          label: 'Ver'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications), 
          label: 'Notificaciones'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu), 
          label: 'Menú'
        ),
      ],
      onTap: (value) {
        viewCubit.changeCurrentView(value);
        controller.animateToPage(value,
          duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
        controller.jumpToPage( value );
      },
    );
  }
}
