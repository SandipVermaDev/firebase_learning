import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupStorage extends StatefulWidget {
  const SignupStorage({super.key});

  @override
  State<SignupStorage> createState() => _SignupStorageState();
}

class _SignupStorageState extends State<SignupStorage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;

  signUp(String email, String password) async {
    if (email.isEmpty && password.isEmpty && pickedImage == null) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Required fields"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        },
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await uploadData();
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  uploadData() async {
    try{
      UploadTask uploadTask = FirebaseStorage.instance
          .ref("Profile Pics")
          .child(emailController.text.toString())
          .putFile(pickedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("Users")
          .doc(emailController.text.toString())
          .set({
        "profileUrl": url,
        "email": emailController.text.toString(),
      });
      log("User Uploaded");
    }
    catch(ex){
      log(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showAlertBox();
              },
              child: pickedImage != null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(pickedImage!),
                      // child: Icon(Icons.person,size: 80,),
                    )
                  : CircleAvatar(
                      radius: 80,
                      child: Icon(
                        Icons.person,
                        size: 80,
                      ),
                    ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  suffixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: Icon(Icons.password_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                  setState(() {
                    emailController.clear();
                    passwordController.clear();
                  });
                },
                child: Text("Sign Up")),
            // SizedBox(height: 40,),
            // TextButton(onPressed: (){}, child: Text("Already Registered..?  Login."))
          ],
        ),
      ),
    );
  }

  showAlertBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick Image From"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.image),
                title: Text("Gallary"),
              )
            ],
          ),
        );
      },
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }
}
