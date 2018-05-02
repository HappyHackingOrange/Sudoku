import 'package:flutter/material.dart';

void main() => runApp(new SudokuApp());

class SudokuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new SudokuHome(title: 'Flutter Sudoku Home Page'),
    );
  }
}

class SudokuHome extends StatefulWidget {
  SudokuHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SudokuState createState() => new _SudokuState();
}

class _SudokuState extends State<SudokuHome> {
  int _counter = 0;

  List<TableRow> getTableRowLst() {
    List<TableRow> lst = new List<TableRow>();
    for (int i = 0; i < 9; i++) {
      lst.add(getTableRow(i));
    }
    return lst;
  }



  TableRow getTableRow(r) {


    var board =[0, 0, 0, 2, 6, 0, 7, 0, 1,
    6, 8, 0, 0, 7, 0, 0, 9, 0,
    1, 9, 0, 0, 0, 4, 5, 0, 0,
    8, 2, 0, 1, 0, 0, 0, 4, 0,
    0, 0, 4, 6, 0, 2, 9, 0, 0,
    0, 5, 0, 0, 0, 3, 0, 2, 8,
    0, 0, 9, 3, 0, 0, 0, 7, 4,
    0, 4, 0, 0, 5, 0, 0, 3, 6,
    7, 0, 3, 0, 1, 8, 0, 0, 0];

    List<Widget> lst = new List<Widget>();
    for (int i = 0; i < 9; i++) {
      int getElement = board[i+r];
      if (board[i+r] == 0) {
        lst.add(
            new TextField(
              decoration: new InputDecoration(
                  hintText: '     ?',
                  hintStyle: new TextStyle(
                    color: Colors.black.withOpacity(1.0),
                    fontWeight: FontWeight.bold,
                  )
              ),
              textAlign: TextAlign.center,
              keyboardType: new TextInputType.numberWithOptions(),
              //TODO add TextEditingController (onChanged prob not enough)
            ));
      }
      else {
        lst.add(new Text (
            '\n$getElement',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(1.0)),
            textAlign: TextAlign.center
        ));
      }
    }


    return new TableRow(children: lst);
  }

  @override
  Widget build(BuildContext context) {
    Table board = new Table(
      children: getTableRowLst(),
      border: new TableBorder.all(
          color: Colors.blueAccent
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Solve this Sudoku!"),
      ),
      body: Center(
          child: board
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        child: new Icon(Icons.local_florist),
      ),
    );
  }
}
