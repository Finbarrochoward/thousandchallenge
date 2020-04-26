import 'package:flutter/material.dart';
import './languagedicts.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class CorrectManager extends ChangeNotifier {
  int _state = 1; // 1 = no change, 2 = correct, 3 = incorrect
  String _visibleWord;
  String _invisibleWord;
  String _userWord;

  int get state => _state;
  String get visibleWord => _visibleWord;
  String get invisibleWord => _invisibleWord;
  String get userWord => _userWord;

  set state(int newVal) {
    // if (_state == newVal) {
    //   _state = newVal;
    //   return;
    // }
    _state = newVal;
    notifyListeners();
    // _state = 1;
  }

  set visibleWord(String newWord) {
    _visibleWord = newWord;
    // notifyListeners();
  }

  set invisibleWord(String newWord) {
    _invisibleWord = newWord;
    // notifyListeners();
  }

  set userWord(String newWord) {
    _userWord = newWord;
    // notifyListeners();
  }
}

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

class _ForeignWordState extends State<ForeignWord> {
  final Map langDicts = {
    "enToDe": englishToGerman,
    "deToEn": germanToEnglish,
    "enToFr": englishToFrench
  };

  Map currLang;
  List<String> currLangList;
  String invisWord;
  String visWord;

  @override
  Widget build(BuildContext context) {
    currLang = langDicts[widget.lang];
    currLangList = currLang.keys.toList();
    invisWord = currLangList[generateRandom(currLangList.length)];
    visWord = currLang[invisWord];
    final status = Provider.of<CorrectManager>(context);
    status.visibleWord = visWord;
    status.invisibleWord = invisWord;

    return Column(
      children: <Widget>[
        VisWordBox(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(child: ValidationForm()),
          ),
        ),
      ],
    );
  }
}

// Box where word is displayed

// class VisWordBox extends StatefulWidget {
//   final String word;
//   // final int isCorrect;
//   VisWordBox({this.word});

//   @override
//   _VisWordBoxState createState() => _VisWordBoxState();
// }

class VisWordBox extends StatelessWidget {
  final List<Color> _colorsList = [Colors.orange, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<CorrectManager>(context);
    final correctWord = status.invisibleWord;
    return Expanded(
      child: Container(
          child: Center(
              child: Stack(children: <Widget>[
            Text(status.visibleWord,
                style: TextStyle(fontSize: 30,),),
            Text(correctWord,
                style: TextStyle(fontSize: 30))
          ])),
          decoration: BoxDecoration(color: _colorsList[status.state - 1])),
    );
  }
}

class ValidationForm extends StatefulWidget {
  @override
  _ValidationFormState createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<CorrectManager>(context);
    return Padding(
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
                      status.userWord = value;
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
                  final status =
                      Provider.of<CorrectManager>(context, listen: false);
                  if (_formKey.currentState.validate()) {
                    if (status.invisibleWord == status.userWord) {
                      status.state = 2;
                      // print(status.state);
                    } else {
                      status.state = 3;
                    }
                  }
                },
                child: Text("Submit"),
                elevation: 0,
              )
            ])));
  }
}
