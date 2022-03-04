import 'package:cinema_mobile_app/cinema-page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VilleList extends StatefulWidget {
  @override
  _VilleListState createState() => _VilleListState();
}

class _VilleListState extends State<VilleList> {
  List<dynamic> listevilles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Villes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            )),
      ),
      body: Center(
        child: this.listevilles == null
            ? CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              )
            : ListView.builder(
                itemCount:
                    this.listevilles == null ? 0 : this.listevilles.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.blue,
                          height: 40.0,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 2.0, right: 6.0),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new Cinema(listevilles[index])));
                              },
                              label: Text(
                                '             ' +
                                    this.listevilles[index]['name'],
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              icon: Icon(
                                Icons.location_city,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  onSurface: Colors.white,
                                  onPrimary: Colors.black,
                                  primary: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.lightBlue,
                  );
                }),
      ),
    );
  }

  @override
  void initState() {
    // qui s'execute au momment de l'initialisation de widget
    super.initState();
    loadVille();
  }

  void loadVille() {
    //indique l'adresse du serveur  192.168.43.208:8080
    //localhost ne ;arche pas avec emulateur mais plutot les smartphone
    String url = "http://192.168.43.254:8080/villes";
    http.get(Uri.parse(url)).then((value) {
      //qui permet que un widget change d'etat au cours de sa vie (interaction)
      setState(() {
        listevilles = json.decode(value.body)['_embedded']['villes'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
