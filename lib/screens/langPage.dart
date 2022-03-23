import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:login/screens/loginpage.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}
class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

class _LanguageScreenState extends State<LanguageScreen> {


  String _selectedLocation = "English";
  var languages = ['English'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Center(
              child: Text(
                "Please select your Language",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize:23 ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Center(
              child: Text(
                "you can change the language \n at any time",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300,fontSize:20,color: Colors.grey,),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: DropdownButton<String>(


               hint: const Text("Please select an language"),

               underline: const SizedBox(),
              items: languages.map((String item){
                return DropdownMenuItem(child: Text(item),value: item);
    }).toList(),
              value: _selectedLocation,
              onChanged: (String? country){

              setState(() {_selectedLocation = country! ;}  );

            },

            ),
          ),

          Container(
            margin: const EdgeInsets.all(15),
            width: double.infinity,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (c) => const LoginPage()));
              },
              child: const Text('Next',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ),
          ),

        ],
      ),
    );
  }
}
