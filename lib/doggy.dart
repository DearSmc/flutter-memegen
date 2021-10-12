// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/service/authentication.dart';

class DoggyPage extends StatefulWidget {
  const DoggyPage({Key? key}) : super(key: key);

  @override
  _DoggyPageState createState() => _DoggyPageState();
}

class _DoggyPageState extends State<DoggyPage> {
  @override
  Widget build(BuildContext context) {
    late User currentUser;
    String displayName = '';

    return Scaffold(
      backgroundColor: Color(0xFF514ABF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
                  margin: const EdgeInsets.all(30.0),
                  child: Text("And ... He's",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      )))),
          Center(
              child: Stack(children: [
            Center(
                // widthFactor: 200.0,
                // heightFactor: 200.0,
                child: Image(image: AssetImage('asset/Group_220.png'))),
            Center(child: Image(image: AssetImage('asset/Group_216.png'))),
          ])),
          Text("Husky",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 40)),
          Center(
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  width: 300,
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Porttitor risus in cras id viverra neque urna malesuada aliquet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 13)))),
          Container(
              color: Colors.white,
              child: Center(
                  child: TextButton(
                      onPressed: () async {
                        print('Register');
                        currentUser = await MyAuthen.register(
                            'sumincha_chalowong@outlook.com',
                            '123456',
                            'newAccount');
                        print(currentUser);
                        // await MyAuthen.signIn('62010978@kmitl.ac.th', '123456');
                        // print(MyAuthen.getUser());
                        // await MyAuthen.signOut();
                        setState(() {
                          displayName = currentUser.displayName!;
                        });
                      },
                      child: Text('sign in')))),
          Container(
            child: Text(displayName),
          )
        ],
      ),
    );
  }
}
