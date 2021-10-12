// ignore_for_file: avoid_print, file_names, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/service/authentication.dart';

class signInAndRegisterPage extends StatefulWidget {
  const signInAndRegisterPage({Key? key}) : super(key: key);

  @override
  _signInAndRegisterPageState createState() => _signInAndRegisterPageState();
}

class _signInAndRegisterPageState extends State<signInAndRegisterPage> {
  @override
  Widget build(BuildContext context) {
    late User currentUser;
    String displayName = '';

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        color: Colors.blue,
                        width: 100.0,
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                            child: TextButton(
                                onPressed: () async {
                                  await MyAuthen.signIn(
                                      '62010978@kmitl.ac.th', '123456');
                                  currentUser = MyAuthen.getUser()!;
                                  print(currentUser);
                                  setState(() {
                                    displayName = currentUser.displayName!;
                                  });
                                  await MyAuthen.signOut();
                                },
                                child: Text('Sign in',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))))),
                    Container(
                        color: Colors.blue,
                        width: 100.0,
                        height: 50.0,
                        child: Center(
                            child: TextButton(
                                onPressed: () async {
                                  print('Register');
                                  currentUser = await MyAuthen.register(
                                      'sumincha_chalowong@outlook.com',
                                      '123456',
                                      'newAccount');
                                  print(
                                      "-----------------------  currentUser ------------------");
                                  print(currentUser);
                                  // await MyAuthen.signIn('62010978@kmitl.ac.th', '123456');
                                  // print(MyAuthen.getUser());
                                  // await MyAuthen.signOut();S
                                  setState(() {
                                    displayName = currentUser.displayName!;
                                  });
                                },
                                child: Text('Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))))),
                  ]),
              Container(
                child: Text("displayName: "),
              ),
              Container(
                child: Text(displayName),
              ),
            ])));
  }
}
