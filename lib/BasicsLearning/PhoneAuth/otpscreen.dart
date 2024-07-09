
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../CloudFirestore/cloud_firestore.dart';

class Otpscreen extends StatefulWidget {
  final String verificationid;

  const Otpscreen({super.key,required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpControlleer=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpControlleer,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Enter OTP",
                suffixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                )
              ),
            ),
          ),
          const SizedBox(height: 50,),
          FilledButton(onPressed: () {
            try{
              PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpControlleer.text.toString());

              FirebaseAuth.instance.signInWithCredential(credential).then((onValue){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CloudFirestore(),));
              });
            }catch(ex){
              log(ex.toString());
            }
          }, child: const Text("Verify OTP"))
        ],
      ),
    );
  }
}
