import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black12,
      elevation: 0,
      child: Column(
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
                        children: const [
                          Text('Jared Levi'),
                          Text('Hace un momento'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      
              IconButton(onPressed: (){}, icon: const Icon( Icons.more_horiz )),
      
            ],
          ),

          const SizedBox(
            height: 8
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Aliqua officia velit veniam ex minim. In nisi Lorem magna elit mollit nulla eiusmod reprehenderit anim nulla. Excepteur non duis cillum culpa qui occaecat pariatur ea. Esse voluptate sit veniam excepteur adipisicing aliquip laborum excepteur dolor mollit reprehenderit aliqua. Esse aliqua anim quis dolor deserunt veniam nostrud. Adipisicing ullamco sunt nostrud incididunt non ea dolore pariatur exercitation est occaecat quis.',
              style: TextStyle( fontSize: 15 ),
              textAlign: TextAlign.start,
            ),
          ),

          Container(
            width: double.infinity,
            height: 250,
            child: const Icon( Icons.photo ),
          ),

          Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    
                    Text('42 reacciones'),
                    Text('64 comentarios'),
              
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(onPressed: (){}, icon: const Icon( Icons.favorite ), label: Text('Me gusta')),
                  TextButton.icon(onPressed: (){}, icon: const Icon( Icons.comment ), label: Text('Comentarios')),
                  TextButton.icon(onPressed: (){}, icon: const Icon( Icons.share ), label: Text('Compartir')),
                ],
              )

            ],
          )
      
        ],
      ),
    );
  }
}