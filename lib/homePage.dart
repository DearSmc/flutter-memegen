// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, curly_braces_in_flow_control_structures, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:meme_generator/editMeme.dart';
import 'package:meme_generator/meme_data.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int maxMeme = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Select meme',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: [
                for (var i = 0; i < maxMeme; i++)
                  // GestureDetector()
                  RawMaterialButton(
                      onPressed: () {
                        print(memeName[i]);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return editMemePage(imageName: memeName[i]);
                        }));
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 4) / 3,
                        height: (MediaQuery.of(context).size.width - 4) / 3,
                        // color: Colors.amber[200],
                        child: Image.asset('asset/meme/meme/${memeName[i]}.jpg',
                            fit: BoxFit.cover),
                      ))
              ],
            ),
            maxMeme < memeName.length
                ? Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (maxMeme + 30 < memeName.length)
                            maxMeme += 30;
                          else
                            maxMeme = memeName.length;
                        });
                      },
                      child: Text("Load More"),
                    ),
                  )
                : Container()
          ],
        )));
  }
}
