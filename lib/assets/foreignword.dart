import 'package:flutter/material.dart';
import './languagedicts.dart';
import 'dart:math';
import 'dart:async';

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
  // Animation<Color> animation;
  // AnimationController controller;
  // StreamController<String> streamCont = StreamController<String>.broadcast();
  // StreamSubscription sub;

  // @override
  // void initState() {
  //   super.initState();
  //   controller =
  //       AnimationController(duration: const Duration(seconds: 2), vsync: this);
  //   animation =
  //       ColorTween(begin: Colors.green, end: Colors.orange).animate(controller)
  //         ..addListener(() {
  //           Stream stream = streamCont.stream;
  //           stream.listen((value) {
  //             print(value);
  //           });
  //           // setState(() {
  //           // The state that has changed here is the animation object’s value.
  //           // });
  //         });
  //   controller.forward();
  // }

  final Map langDicts = {
    "enToDe": englishToGerman,
    "deToEn": germanToEnglish,
    "enToFr": englishToFrench
  };

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var currLang = langDicts[widget.lang];
    var currLangList = currLang.keys.toList();
    var invisWord = currLangList[generateRandom(currLangList.length)];
    var visWord = currLang[invisWord];
    String _currWord;
    bool isCorrect = false;
    final TextEditingController _textController = TextEditingController();

    return Column(
      children: <Widget>[
        VisWordBox(word: visWord),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: _textController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter a word";
                              } else {
                                _currWord = value;
                                return null;
                              }
                            },
                            decoration:
                                InputDecoration(hintText: "Translation"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (invisWord == _currWord) {
                                // streamCont.add("Correct");
                                isCorrect = true;
                              } else {
                                isCorrect = false;
                              }
                              setState(() {
                                _textController.clear();
                                if (isCorrect) {
                                  print("correct");
                                } else {
                                  print("incorrect");
                                  visWord = "incorrect";
                                }
                              });
                            }
                          },
                          child: Text("Submit"),
                          elevation: 0,
                        )
                      ]))),
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

class VisWordBox extends StatefulWidget {
  final String word;
  final bool isCorrect;
  VisWordBox({this.word, this.isCorrect});

  @override
  _VisWordBoxState createState() => _VisWordBoxState();
}

class _VisWordBoxState extends State<VisWordBox>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation =
        ColorTween(begin: Colors.orange, end: Colors.green).animate(controller)
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child:
              Center(child: Text(widget.word, style: TextStyle(fontSize: 30))),
          decoration: BoxDecoration(
            color: animation.value,
          )),
    );
  }
}
