import 'package:flutter/material.dart';
import 'package:red_social/src/widgets/widgets.dart';

class MovieView extends StatelessWidget {
const MovieView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Text(
                      'Ver',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                 ),

                 Row(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon( Icons.save )),
                  ],
                 )
               ],
             ),

             SingleChildScrollView(
              padding: const EdgeInsets.symmetric( horizontal: 10 ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [

                  ElevatedButton(
                    onPressed: (){},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                    ), 
                    child: const Text('Para ti'),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  ElevatedButton(
                    onPressed: (){},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                    ), 
                    child: const Text('En vivo'),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  ElevatedButton(
                    onPressed: (){},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                    ), 
                    child: const Text('Reels'),
                  ),
                  
                  const SizedBox(
                    width: 10,
                  ),

                  ElevatedButton(
                    onPressed: (){},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                    ), 
                    child: const Text('Música'),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  ElevatedButton(
                    onPressed: (){},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                    ), 
                    child: const Text('Gaming'),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  ElevatedButton(
                    onPressed: (){},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                    ), 
                    child: const Text('Siguiendo'),
                  ),

                ],
              ),
             ),

            //PostCard()

          ],
        ),
      ),

    );
  }
}