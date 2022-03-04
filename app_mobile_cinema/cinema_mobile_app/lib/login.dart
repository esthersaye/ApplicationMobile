import 'package:cinema_mobile_app/page-admin.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController code = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  bool security = true;
  List<dynamic> listeUsers;
  Utilisateur utilisateur =
      Utilisateur(username: "votre nom", email: "email", password: "password");
  List<TextEditingController> controllers = List.empty(growable: true);
  Widget build(BuildContext context) {
    showAlertDialog(context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Notification Authentification"),
        content: Text("Authentification incorrect."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Authentification Admin"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                controller: nom,
                decoration:
                    InputDecoration(hintText: 'Your Name', labelText: 'Name'),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                controller: mail,
                decoration:
                    InputDecoration(hintText: 'Your mail', labelText: 'Mail'),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
              child: TextField(
                obscureText: security,
                controller: code,
                maxLength: 8,
                decoration: InputDecoration(
                    hintText: 'Your Code',
                    labelText: 'Code',
                    suffixIcon: IconButton(
                      icon: Icon(
                          security ? Icons.remove_red_eye : Icons.security),
                      onPressed: () {
                        setState(() {
                          security = !security;
                        });
                      },
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: ElevatedButton(
                child: Text(
                  'Validez',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal[400],
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  bool d = fieldValeur(nom.text.toString(),
                      code.text.toString(), mail.text.toString());
                  code.clear();
                  nom.clear();
                  mail.clear();
                  if (d == true) {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Admin()));
                  } else {
                    showAlertDialog(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    // qui s'execute au momment de l'initialisation de widget
    super.initState();
    loaduser();
  }

  void loaduser() {
    String url = "http://192.168.43.254:8080/userses";
    http.get(Uri.parse(url)).then((value) {
      //qui permet que un widget change d'etat au cours de sa vie (interaction)
      setState(() {
        listeUsers = json.decode(value.body)['_embedded']['userses'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  fieldValeur(String string, String string2, String string3) {
    for (int i = 0; i < listeUsers.length; i++) {
      if (listeUsers[i]['name'] == string &&
          listeUsers[i]['code'] == string2 &&
          listeUsers[i]['mail'] == string3) {
        return true;
      }
      return false;
    }
  }
}
