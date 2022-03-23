import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/OTPController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String dialCodeDigits = "+91";
  final TextEditingController _controller = TextEditingController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            const Padding(padding: EdgeInsets.only(left: 28.0, right: 28.0),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Center(
                child: Text(
                  "Please enter your mobile Number",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize:23 ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Center(
                child: Text(
                  "you'll receive a 6 digit code \n to verify next",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300,fontSize:20,color: Colors.grey,),
                ),
              ),
            ),
            const SizedBox(height: 50,),

            Container(
              decoration: BoxDecoration(
                border: Border.all()
              ),
            width: 375,


            child: Row(
          children: <Widget>[

            Expanded(
              flex: 1,
              child:
            CountryCodePicker(
              flagWidth: 14,
              onChanged: (country){
                setState(() {
                  dialCodeDigits = country.dialCode!;
                });
              },
              initialSelection: "IN",
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              favorite: const ['+1',"US","+91","IND",],
            ),
          ),

            Expanded(
              flex: 3,
              child:
            TextField(

            decoration: InputDecoration(
            hintText: "PhoneNumber",
            counterStyle: const TextStyle(height: double.minPositive,),
            counterText: "",
            prefix: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(dialCodeDigits),
            )
            ),
            maxLength: 10,
            keyboardType: TextInputType.number,
            controller: _controller,
            ), )
            ],
        ),),
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
                  if(_controller.text == "")
                    {
                      const SnackBar(content: Text(
                          "please provide a phone number"),
                  duration: Duration(seconds: 3),);
                    }
                  else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) =>
                        OTPControllerScreen(
                          phone: _controller.text,
                          codeDigits: dialCodeDigits,
                        )));
                  }},
                child: const Text('CONTINUE',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
