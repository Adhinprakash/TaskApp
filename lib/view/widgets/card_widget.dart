
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key,  required this.title, required this.description, required this.onPressed});
  final String title;
  final String description;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
    height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.shade700,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1),
             BoxShadow(
                color: Colors.blue.shade200,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1)
          ]
          ,gradient: LinearGradient(
            begin:Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.1,
              0.9
            ],
            colors: 
         [
          Colors.blue.shade200,
          Colors.blue.shade400
         ]
          )
          ),
      child: Stack(
        children: [
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,  // Added to prevent expansion

        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16,color: Colors.white),
             overflow: TextOverflow.ellipsis   
          ),
       
             Text(
            description,
             overflow: TextOverflow.ellipsis,
                         style: TextStyle(fontSize: 13,color: Colors.white),

              maxLines: 2, 
                
          ),
         
          
        ],
      ),
       Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.edit, size: 20,color: Colors.white,),
              onPressed: onPressed,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      )
    );
  }
}