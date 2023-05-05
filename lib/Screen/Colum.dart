import 'package:flutter/material.dart';

class Colum extends StatelessWidget {
  final String url, name;

  const Colum({super.key, required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(url,width: 30,height: 30,),
          SizedBox(height: 5,),
          Text(name,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontSize: 12,),)
        ],
      ),
    );
  }
}
