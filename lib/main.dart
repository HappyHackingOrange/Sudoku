import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<MyHomePage> {
  String img = getNewCat();
  static int count = 0;
  static int cursor = 0;

  static void incCount(){
    if (count != 9){
      count++;
    }
    else {
      count = 1;
    }
  }

  static String getNewCat() {
    incCount();
    return 'set2/'+ count.toString() + '.png';
  }

  List<TableRow> getTableRowLst() {
    List<TableRow> lst = new List<TableRow>();
    for (int i = 0; i < 9; i++) {
      lst.add(getTableRow());
    }
    return lst;
  }

  TableRow getTableRow() {
    List<Widget> lst = new List<Widget>();
    for (int i = 0; i < 9; i++) {
      lst.add(new IconButton(
        icon: Image.asset(
          img,
        ),
        iconSize: 24.0,
        onPressed: () {
          setState(() {
            img = getNewCat();
          });
        },
      ),
      );
    }
    return new TableRow(children: lst);
  }

  List<TableRow> getKeyRowlst() {
    List<TableRow> lst = new List<TableRow>();
    lst.add(getTableRow());
    return lst;
  }

  TableRow getKeyRow() {
    List<Widget> lst = new List<Widget>();
    for (int i = 1; i <= 9; i++) {
      lst.add(new IconButton(
        icon: Image.asset(
            'set2/'+ i.toString() + '.png'
        ),
        iconSize: 24.0,
        onPressed: () {
          setState(() {
            cursor = i;
          });
        },
      ),
      );
    }
    return new TableRow(children: lst);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Cat Button'),
        ),
        body: new Column(
          children:[
          new Table(
            children: getTableRowLst(),
            border: new TableBorder.all(
                color: Colors.blueAccent
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(top:.0),
            child: new Table(
              children: getKeyRowlst(),
              border: new TableBorder.all(
                  color: Colors.redAccent
              ),
            )
          )

    ]
        ));
  }
}