import 'package:flutter/material.dart';
import './assets/foreignword.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thousand Challenge',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'TC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int counter;

  String langText;

  List <String> languagesStrings = <String>['German', 'Greek', 'French'];

  Map languagesSwitchFalse = {
    'German': "enToDe",
    'French': "enToFr",
  };
  String currentLang = 'enToDe';


  void increaseCounter() {
    counter++;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.title),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.compare_arrows),),
        actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: langText,
              style: TextStyle(color: Colors.black),
              underline: null,
              onChanged: (String newValue) {
                setState(() {
                  currentLang = languagesSwitchFalse[newValue];
                  langText = newValue;
                });
              },
              items: languagesStrings
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
        ],
      ),
      body: ForeignWord(lang: currentLang),
    );
  }
}
