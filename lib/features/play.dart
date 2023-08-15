import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scissor/custom_widget/image_button.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  Timer? _timer;
  int _pos = 0;
  int pressedButton = 0;

  int _win = 0;

  List<String> assets = [
    "lib/assets/img/rock.png",
    "lib/assets/img/paper.png",
    "lib/assets/img/scissor.png"
  ];

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _pos = (_pos + 1) % assets.length;
      });
    });
    super.initState();
  }

  void buttonPress() {
    setState(() {
      _pos = 0;
      pressedButton = 0;
      _win = 0;
      _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
        setState(() {
          _pos = (_pos + 1) % assets.length;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    _timer = null;
    super.dispose();
  }

  void moveSelectPress(int i) {
    setState(() {
      _timer!.cancel();
      _timer = null;
      _pos = Random().nextInt(assets.length);
      pressedButton = i;
      if ((i - 1) == _pos) {
        _win = 1;
      } else if (((i - 1) == 0 && _pos == 2) ||
          ((i - 1) == 1 && _pos == 0) ||
          ((i - 1) == 2 && _pos == 1)) {
        _win = 2;
      } else {
        _win = 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(assets[_pos])),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey.shade100,
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer)
              ]),
        ),
        SizedBox(height: 20),
        Text(
          "Select Your Move",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageButton(
              image: AssetImage(assets[0]),
              title: "Rock",
              width: 60,
              height: 60,
              isPressed: (pressedButton == 1),
              onTap: () {
                if (_win == 0) moveSelectPress(1);
              },
            ),
            ImageButton(
              image: AssetImage(assets[1]),
              title: "Paper",
              width: 60,
              height: 60,
              isPressed: (pressedButton == 2),
              onTap: () {
                if (_win == 0) moveSelectPress(2);
              },
            ),
            ImageButton(
              image: AssetImage(assets[2]),
              title: "Scissor",
              width: 60,
              height: 60,
              isPressed: (pressedButton == 3),
              onTap: () {
                if (_win == 0) moveSelectPress(3);
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        _win != 0
            ? Text(
                (_win == 1
                    ? "Draw"
                    : _win == 2
                        ? "You Win"
                        : "You Lose"),
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : SizedBox(
                height: 5,
              ),
        SizedBox(
          height: 10,
        ),
        _win != 0
            ? ElevatedButton(
                onPressed: () {
                  buttonPress();
                },
                child: Text("Again"),
              )
            : SizedBox(
                height: 10,
              )
      ],
    )));
  }
}
