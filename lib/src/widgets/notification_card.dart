import 'package:flutter/material.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [

            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.08,
              child: const Icon( Icons.person_2 ),
            ),

            const SizedBox(
              width: 10,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [

                  Text('Jared Levi te ha mencionado en un comentario.'),
                  Text('Ayer a las 14:23', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w300 ),),

                ],
              )
            ),

            IconButton(onPressed: (){}, icon: const Icon( Icons.more_horiz ))
          ],
        ),

        const Divider()

      ],
    );
  }
}