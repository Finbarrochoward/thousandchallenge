import 'package:flutter/material.dart';

class ForeignWord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              child: Center(
                  child: Text("ForeignWord", style: TextStyle(fontSize: 30))),
              decoration: BoxDecoration(
                color: Colors.orange,
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
                  child: ValidationForm()),
            ),
          ),
        ),
      ],
    );
  }
}

class ValidationForm extends StatefulWidget {
  @override
  _ValidationFormState createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final _formKey = GlobalKey<FormState>();

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
                }
                else {
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
              _formKey.currentState.validate();
            },
            child: Text("Submit"),
            elevation: 0,
          )
        ]));
  }
}

// Copy
// class ForeignWord extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//           child: Container(
//               child: Center(
//                   child: Text("ForeignWord", style: TextStyle(fontSize: 30))),
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//               )),
//         ),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Center(
//               child: Padding(
//                   padding: const EdgeInsets.only(left: 50.0, right: 50.0),
//                   child: ValidationForm()),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
