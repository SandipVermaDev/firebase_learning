import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otpscreen.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: "Enter Phone numbner",
                  prefix: const Text("+91"),
                  suffixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          FilledButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (phoneAuthCredential) {},
                  verificationFailed: (error) {},
                  codeSent: (verificationId, forceResendingToken) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Otpscreen(verificationid: verificationId),));
                  },
                  codeAutoRetrievalTimeout: (verificationId) {},
                  phoneNumber: "+91${phoneController.text}",
                );
              },
              child: const Text("Verify Your Number"))
        ],
      ),
    );
  }
}
