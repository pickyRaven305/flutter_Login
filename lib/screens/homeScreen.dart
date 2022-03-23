import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/loginpage.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int group = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 65,right: 65,left: 65),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),

              child: ListTile(
              title: Column(
                  children:const [ Text('Shipper'),
                Text("Random text")]),
              leading: Radio(
                value:1,
                groupValue: group,
                onChanged: (T) {
                 
                  setState(() {
                    group = T as int;
                  });
                },
                toggleable: true,
              ),

            ),),
    Container(
      margin: const EdgeInsets.only(top:20,bottom: 65,right: 65,left: 65),
      width: double.infinity,
    decoration: BoxDecoration(border: Border.all()),
            child: ListTile(
              title: Column(
                  children:const [ Text('Transporter'),
                    Text("Random text")]),
              leading: Radio<int>(
                value:2,
                groupValue: group,
                onChanged: (T) {

                  setState(() {
                    group = T as int;
                  });
                },
                toggleable: true,
              ),

            ),),


            Container(
              margin: const EdgeInsets.all(65),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: (){

                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) => const LoginPage()));
                }, child: const Text('Logout',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),


              ),
            )
          ],
      ),
    );
  }
}
