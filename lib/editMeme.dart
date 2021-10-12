// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unnecessary_new

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class editMemePage extends StatefulWidget {
  final String imageName;

  const editMemePage({Key? key, required this.imageName}) : super(key: key);

  @override
  _editMemePageState createState() => _editMemePageState();
}

class _editMemePageState extends State<editMemePage> {
  String topText = '';
  String bottomText = '';
  TextEditingController topController = TextEditingController();
  TextEditingController bottomController = TextEditingController();
  GlobalKey globalKey = new GlobalKey();
  double xt = 60, yt = 0, xb = 60, yb = 100;
  double appBarHeight = 0;
  double fontSize = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topText = "Top Text";
    bottomText = "Bottom Text";
    topController.text = topText;
    bottomController.text = bottomText;
    fontSize = 52;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Add text',
            style: TextStyle(color: Colors.black),
          )),
      body: ListView(
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                        child: Image.asset(
                            'asset/meme/meme/${widget.imageName}.jpg'));
                  },
                  //? cr. https://www.woolha.com/tutorials/flutter-using-longpressdraggable-examples
                  onAcceptWithDetails: (DragTargetDetails<String> details) {
                    var newX =
                        details.offset.dx - MediaQuery.of(context).padding.left;
                    var newY = details.offset.dy -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top;
                    setState(() {
                      if (details.data == 'top') {
                        xt = newX;
                        yt = newY;
                      } else if (details.data == 'bottom') {
                        xb = newX;
                        yb = newY;
                      }
                    });
                  },
                ),
                //? cr. https://api.flutter.dev/flutter/widgets/Draggable-class.html
                Positioned(
                  left: xt,
                  top: yt,
                  child: Draggable(
                    data: 'top',
                    child: buildStorkText(topText, Colors.white, fontSize),
                    feedback: buildStorkText(topText, Colors.white, fontSize),
                    childWhenDragging: Container(),
                  ),
                ),
                Positioned(
                    left: xb,
                    top: yb,
                    child: Draggable(
                      data: 'bottom',
                      child: buildStorkText(bottomText, Colors.white, fontSize),
                      feedback:
                          buildStorkText(bottomText, Colors.white, fontSize),
                      childWhenDragging: Container(),
                    )),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  buildTextField(topController, (text) {
                    setState(() {
                      topText = text;
                    });
                  }, 'add Top text'),
                  SizedBox(height: 24),
                  buildTextField(bottomController, (text) {
                    setState(() {
                      bottomText = text;
                    });
                  }, 'add bottom text'),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 52,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              fontSize -= 1;
                            });
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[400]),
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 52,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              fontSize += 1;
                            });
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[400]),
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),
                  //sizedBox
                  Container(
                    height: 52,
                    width: double.infinity,
                    color: Colors.blue,
                    child: TextButton(
                      onPressed: () {
                        print('export');
                        shareMeme();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF0880AE)),
                      ),
                      child: Text(
                        'Export',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              )),
        ],
      ),
    );
  }

  TextField buildTextField(TextEditingController controller,
      Function(String) onChanged, String hintText) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        onChanged(value);
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE8E8E6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE8E8E6)),
        ),
        fillColor: Color(0xFFF7F7F7),
        filled: true,
        hintText: hintText,
      ),
    );
  }

  Stack buildStorkText(String text, Color upperColor, double inputSize) {
    return Stack(
      children: [
        Text(text,
            style: TextStyle(
              fontSize: inputSize,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            )),
        Text(text,
            style: TextStyle(
                fontSize: inputSize,
                fontWeight: FontWeight.bold,
                color: upperColor)),
      ],
    );
  }

  Future<void> shareMeme() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imageFile = File('$directory/meme.png');
      imageFile.writeAsBytesSync(pngBytes);

      Share.shareFiles(['$directory/meme.png']);
    } catch (e) {
      print(e);
    }
  }
}
