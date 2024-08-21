import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> taped = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  bool player = true;

  var myStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
  var scoreStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w700);
  int oscore = 0;
  int xscore = 0;
  int drawScore = 0;
  int fillbox = 0;
  String X = 'X';
  String O = 'O';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text("Tic Tac Toe", style: myStyle),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  restart();
                },
                child: Icon(Icons.refresh_outlined, color: Colors.black)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Player X', style: myStyle),
                          Text(xscore.toString(), style: scoreStyle),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Player O', style: myStyle),
                          Text(oscore.toString(), style: scoreStyle),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _taped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2.0),
                    ),
                    child: Center(
                      child: Text(
                        taped[index],
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: taped[index] == 'X'
                                ? Colors.red[500]
                                : Colors.green[500]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Text('Draw: ' + drawScore.toString(), style: scoreStyle),
            ),
          )
        ],
      ),
    );
  }

  void restart() {
    cleanxo();
    xscore = 0;
    oscore = 0;
    drawScore = 0;
    fillbox = 0;
  }

  void _taped(int index) {
    setState(() {
      if (player && taped[index] == '') {
        taped[index] = X;
        player = !player;
        fillbox += 1;
      } else if (!player && taped[index] == '') {
        taped[index] = O;
        player = !player;
        fillbox += 1;
      }

      checkWin();
    });
  }

  void checkWin() {
    if (taped[0] == taped[1] && taped[0] == taped[2] && taped[0] != '') {
      showWin(taped[0]);
    }
    //2row
    else if (taped[3] == taped[4] && taped[3] == taped[5] && taped[3] != '') {
      showWin(taped[3]);
    }
    //3row
    else if (taped[6] == taped[7] && taped[6] == taped[8] && taped[6] != '') {
      showWin(taped[6]);
    }
    //1col
    else if (taped[0] == taped[3] && taped[0] == taped[6] && taped[0] != '') {
      showWin(taped[0]);
    }
    //2col
    else if (taped[1] == taped[4] && taped[1] == taped[7] && taped[1] != '') {
      showWin(taped[1]);
    }
    //3col
    else if (taped[2] == taped[5] && taped[2] == taped[8] && taped[2] != '') {
      showWin(taped[2]);
    } else if (taped[0] == taped[4] && taped[0] == taped[8] && taped[0] != '') {
      showWin(taped[0]);
    } else if (taped[2] == taped[4] && taped[2] == taped[6] && taped[2] != '') {
      showWin(taped[2]);
    } else {
      drawmeth();
    }
  }

  void drawmeth() {
    if (fillbox == 9) {
      _showdraw();
      drawScore += 1;
    }
  }

  void _showdraw() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw!!! ", style: myStyle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cleanxo();
                  },
                  child: Text('Play again!!'))
            ],
          );
        });
  }

  void showWin(String Winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner :  " + Winner, style: myStyle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cleanxo();
                  },
                  child: Text('Play again!!'))
            ],
          );
        });
    if (Winner == 'X') {
      xscore += 1;
    } else if (Winner == 'O') {
      oscore += 1;
    }
  }

  void cleanxo() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        taped[i] = '';
      }
    });
    fillbox = 0;
  }
}
