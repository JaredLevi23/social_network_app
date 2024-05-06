import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/users/users_bloc.dart';
import 'package:red_social/src/widgets/widgets.dart';

class RequestsView extends StatefulWidget {
const RequestsView({ Key? key }) : super(key: key);

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {

  @override
  void initState() {
    
    SchedulerBinding.instance.addPostFrameCallback((_) {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              const Text(
                'Amigos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll( Colors.black12 )
                      ),
                      onPressed: (){}, 
                      child: const Text('Sugerencias')
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll( Colors.black12 )
                      ),
                      onPressed: (){}, 
                      child: const Text('Tus amigos')
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll( Colors.black12 )
                      ),
                      onPressed: (){}, 
                      child: const Text('Amigos cercanos')
                    ),

                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              const Text(
                'Solicitudes de amistad',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              
              BlocBuilder<UsersBloc, UsersState>(
                builder: (_, state){

                  return const Text( 'No hay solicitudes' );

                }
              )


          ],
        ),
      )

    );
  }
}
