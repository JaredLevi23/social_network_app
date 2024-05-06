import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
const MessagesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: const Text('Mensajes'),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('En linea'),
          ),

          Container(
            padding: const EdgeInsets.symmetric( horizontal: 10 ),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [

                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),
                  AvatarChat(),

                ],
              ),
            ),
          ),

          Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (_, index){
          
                return const ListTile(
                  leading: CircleAvatar(
                    child: Icon( Icons.person_2 ),
                  ),
                  trailing: Icon( Icons.arrow_forward_ios_outlined ),
                  title: Text('Jared Gonzalez'),
                  subtitle: Text(
                    'Hola mundo, esta es una prueba de un mensaje de texto en la pagina de los mensajes',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
          
              }
            ),
          ),
        ],
      )
    );
  }
}

class AvatarChat extends StatelessWidget {
  const AvatarChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all( 5 ),
      child: Column(
        children: [
          CircleAvatar(
            child: Icon( Icons.person_2 ),
          ),
          Text('${'Jared'.padRight(6,' ').substring(0,6)}', maxLines: 1)
        ],
      ),
    );
  }
}