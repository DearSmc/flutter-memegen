import 'package:flutter/material.dart';

// stl => stateless widget
// stf => stateful widget

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  PageController pageControler = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Center(child: Text('leading')),
        title: Text('Title'),
        actions: [Text('act1'), Text('act2')],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          print(value);
          setState(() {
            currentIndex = value;
            pageControler.jumpToPage(currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.account_balance_wallet_outlined), label: ''),
        ],
      ),
      body: PageView(
        // physics: NeverScrollableScrollPhysics(),
        controller: pageControler,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        children: [
          Container(
            color: Colors.lightBlue[100],
            child: Center(child: Text('Home Page')),
          ),
          Container(
            color: Colors.red[100],
            child: Center(child: Text('Fav Page')),
          ),
          Container(
            color: Colors.green[100],
            child: Center(child: Text('Add Page')),
          ),
        ],
      ),
    );
  }
}
