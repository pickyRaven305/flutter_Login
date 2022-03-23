import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/homeScreen.dart';
import 'package:pinput/pin_put/pin_put.dart';


class OTPControllerScreen extends StatefulWidget {

  final String phone;
  final String codeDigits;
  const OTPControllerScreen( {Key? key, required this.phone, required this.codeDigits}) : super(key: key);


  @override
  State<OTPControllerScreen> createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();
  String? verifictaionCode;

  final BoxDecoration pinOTPDecortaion = BoxDecoration(
    color: Colors.lightBlue[100],

    border: Border.all(
      color: Colors.white,
    )
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    verifyPhoneNumber();
  }

  verifyPhoneNumber() async{

      await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: "${widget.codeDigits + widget.phone}", verificationCompleted: (PhoneAuthCredential credential)async{
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
          if (value.user != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (
                c) => const HomeScreen()));
          }
        });
      }, verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      }, codeSent: (String vID, int? resendToken){

        setState(() {
          verifictaionCode = vID;
        });

      }, codeAutoRetrievalTimeout: (String vID){

      setState(() {
        verifictaionCode = vID;
      });
      },timeout: const Duration(seconds: 40),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(8.0),

          ),

          Container(
            margin:const EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: (){
                  verifyPhoneNumber();

                },
                child: const Text(
                  "Verify Phone\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
            )
          ),
          Center(
            child: GestureDetector(
              onTap: (){
                verifyPhoneNumber();

              },
              child: Text(
                "code sent to ${widget.phone}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 16,color: Colors.grey),
              ),
            ),
          ),
             Padding(
            padding: const EdgeInsets.all(40.0),
            child: PinPut(

              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25,color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinOTPFocus,
              controller: _pinOTPCodeController,
              followingFieldDecoration: pinOTPDecortaion,
              submittedFieldDecoration: pinOTPDecortaion,
              selectedFieldDecoration: pinOTPDecortaion,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider
                      .credential(
                      verificationId: verifictaionCode!, smsCode: pin)).then((
                      value) {
                    if (value.user != null) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (
                          c) => const HomeScreen()));
                    }
                  });
                }
                catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                        "Invalid OTP"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },

            )
          ),

        ],
      ),
    );
  }
}
