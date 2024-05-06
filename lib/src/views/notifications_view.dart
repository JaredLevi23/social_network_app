import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class NotificationsView extends StatelessWidget {
const NotificationsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
        child: Column(
          children: const [

            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),

          ],
        ),
      ),

    );
  }
}
