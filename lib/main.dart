import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var squares;
  late bool isXnext;

  initialize() {
    setState(() {
      squares = List.filled(9, '');
      isXnext = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 20,
        title: Center(
          child: Text("Tic Tac Toe",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 27.5,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Now Player ${isXnext ? 'X' : 'O'}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeSquare(0),
              makeSquare(1),
              makeSquare(2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeSquare(3),
              makeSquare(4),
              makeSquare(5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeSquare(6),
              makeSquare(7),
              makeSquare(8),
            ],
          )
        ],
      )),
    );
  }

  showAlert(String msg) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("TMG"),
              content: Text(
                msg,
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      initialize();
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ))
              ],
            ));
  }

  markSquare(int number) {
    setState(() {
      squares[number] = isXnext ? 'X' : 'O';
      isXnext = !isXnext;
    });
    if (checkWinner()) {
      showAlert("Winner is ${isXnext ? 'O ' : 'X'}");
    } else {
      if (!squares.contains('')) {
        showAlert("It's a Draw");
      }
    }
  }

  bool checkWinner() {
    var lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var i in lines) {
      int a = i[0];
      int b = i[1];
      int c = i[2];
      if (squares[a] != '' &&
          squares[a] == squares[b] &&
          squares[b] == squares[c]) {
        return true;
      }
    }
    return false;
  }

  makeSquare(int number) {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: () {
          if (squares[number] == '') {
            markSquare(number);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.white),
            ],
            border: Border.all(width: 5, color: Colors.black),
          ),
          child: Center(
            child: Text(
              "${squares[number]}",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
