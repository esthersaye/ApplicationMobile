import 'package:cinema_mobile_app/Salle-page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cinema extends StatefulWidget {
  @override
  _CinemaState createState() => _CinemaState();
  dynamic villes;
  Cinema(this.villes);
}

class _CinemaState extends State<Cinema> {
  List<dynamic> listecinemas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinema de ${widget.villes['name']}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            )),
      ),
      body: Center(
        child: this.listecinemas == null
            ? CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : ListView.builder(
                itemCount:
                    this.listecinemas == null ? 0 : this.listecinemas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Divider(
                          height: 40.0,
                          color: Colors.blue,
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
                                            new Salle(listecinemas[index])));
                              },
                              label: Text(
                                this.listecinemas[index]['name'] + '      ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              icon: Icon(
                                Icons.movie,
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
    loadCinema();
  }

  void loadCinema() {
    //indique l'adresse du serveur 192.168.43.254
    //localhost ne ;arche pas avec emulateur mais plutot les smartphone
    String url = this.widget.villes['_links']['cinema']['href'];
    http.get(Uri.parse(url)).then((value) {
      //qui permet que un widget change d'etat au cours de sa vie (interaction)
      setState(() {
        listecinemas = json.decode(value.body)['_embedded']['cinemas'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
