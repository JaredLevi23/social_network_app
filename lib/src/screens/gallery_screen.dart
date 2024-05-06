import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_social/src/services/posts_service.dart';

class GalleryScreen extends StatelessWidget {

  final List<ImgModel> imgs;
  final String title;
  final String content;

const GalleryScreen({ Key? key, required this.imgs, required this.title, required this.content }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon( Icons.close )
        ),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric( vertical: 15 ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text( content, style: const TextStyle( color: Colors.white, fontWeight: FontWeight.bold ), ),
              ),
        
        
              Expanded(
                child: PageView(
                  children: [
                    ...imgs.map((e) => Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Image(image: NetworkImage(e.img))),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text( e.description, style: const TextStyle( color: Colors.white, fontWeight: FontWeight.w300 ),),
                          )
                        ],
                      ),
                    ) ).toList()
                  ],
                ),
              ),
        
            ],
          ),
        ),
      ),

    );
  }
}