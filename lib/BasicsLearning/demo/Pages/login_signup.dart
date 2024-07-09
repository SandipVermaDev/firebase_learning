import 'package:flutter/material.dart';

import '../functions/firebase_auth.dart';

class LoginSignPage extends StatefulWidget {
  const LoginSignPage({super.key});

  @override
  State<LoginSignPage> createState() => _LoginSignPageState();
}

class _LoginSignPageState extends State<LoginSignPage> {
  final _formkey = GlobalKey<FormState>();
  bool isLoginPage = true;
  String email='';
  String password='';
  String username='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Email/Password Auth',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isLoginPage
                    ? TextFormField(
                        key: const ValueKey('userName'),
                        decoration:
                            const InputDecoration(labelText: 'Enter Username'),
                        validator: (value) {
                          if(value.toString().length<3){
                            return 'Username is too small';
                          } else{
                            return null;
                          }
                        },
                  onSaved: (newValue) {
                    setState(() {
                      username=newValue!;
                    });
                  },
                      )
                    : Container(),
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(labelText: 'Enter Email'),
                  validator: (value) {
                    if(!(value.toString().contains('@'))){
                      return 'Invalid Email';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    setState(() {
                      email=newValue!;
                    });
                  },
                ),
                TextFormField(
                  key: const ValueKey('Password'),
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Enter Password'),
                  validator: (value) {
                    if(value.toString().length<6){
                      return 'Password is too short';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    setState(() {
                      password=newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoginPage? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {}, child: const Text('Forgot Password ?'))
                  ],
                ) : Container(),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            _formkey.currentState!.save();
                            isLoginPage?signin(email, password):signup(email,password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          isLoginPage ? 'LogIn' : 'SignUp',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ))),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(!isLoginPage?'Already Registered ?':'Do not have Account ?'),
                    // SizedBox(width: 10,),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        },
                        child: Text(!isLoginPage?'Log In':'Sign Up',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
