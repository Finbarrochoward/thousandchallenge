import 'package:flutter/material.dart';
import './languagedicts.dart';
import 'dart:math';

int generateRandom(length) {
  Random random = Random();
  int randomNumber = random.nextInt(length);
  return randomNumber;
}

class ForeignWord extends StatefulWidget {
  final String lang;
  ForeignWord({this.lang});

  @override
  _ForeignWordState createState() => _ForeignWordState();
}

class _ForeignWordState extends State<ForeignWord>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation =
        ColorTween(begin: Colors.green, end: Colors.orange).animate(controller)
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });
    controller.forward();
  }

  final Map langDicts = {
    "enToDe": englishToGerman,
    "deToEn": germanToEnglish,
    "enToFr": englishToFrench
  };

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currLang = langDicts[widget.lang];
    var currLangList = currLang.keys.toList();
    var invisWord = currLangList[generateRandom(currLangList.length)];
    var visWord = currLang[invisWord];

    void callback(isCorrect) {
      setState(() {
        if (isCorrect) {
          print(visWord);
          visWord = "Correct";
          print(visWord);
          // controller.forward();
        } else {
          print("False");
        }
      });
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              child:
                  Center(child: Text(visWord, style: TextStyle(fontSize: 30))),
              decoration: BoxDecoration(
                color: animation.value,
              )),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: ValidationForm(
                      correctWord: invisWord, callback: callback)),
            ),
          ),
        ),
      ],
    );
  }
}

class ValidationForm extends StatefulWidget {
  final String correctWord;
  Function(bool) callback;

  ValidationForm({this.correctWord, this.callback});

  @override
  _ValidationFormState createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final _formKey = GlobalKey<FormState>();
  String _currValue;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Row(children: [
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  print("Empty");
                  return "Please enter a word";
                } else {
                  _currValue = value;
                  return null;
                }
              },
              decoration: InputDecoration(hintText: "Translation"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                if (widget.correctWord.toLowerCase() ==
                    _currValue.toLowerCase()) {
                  // print("Correct");
                  widget.callback(true);
                } else {
                  // print("Incorrect");
                  widget.callback(false);
                }
              }
              // widget.callback(widget.correctWord, _currValue);
            },
            child: Text("Submit"),
            elevation: 0,
          )
        ]));
  }
}
