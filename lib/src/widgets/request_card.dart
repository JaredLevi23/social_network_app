import 'package:flutter/material.dart';


class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 5 ),
      child: Column(
        children: [
          Row(
            children: [
    
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.1,
                child: const Icon( Icons.person_2, size: 40 ),
              ),
    
              const SizedBox(
                width: 10,
              ),
    
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
    
                    const Text('Jared Gonzalez'),
                    const Text('13 amigos en comun'),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
    
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){},
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll( Colors.indigo )
                            ), 
                            child: const Text('Confirmar'),
                          )
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){}, 
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll( Colors.black54 )
                            ), 
                            child: const Text('Eliminar')
                          )
                        ),
    
                      ],
                    )
    
                  ],
                ),
              )
    
            ],
          ),

          const Divider()
        ],
      ),
    );
  }
}