import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Salle extends StatefulWidget {
  @override
  _SalleState createState() => _SalleState();
  dynamic cinemas;
  Salle(this.cinemas);
}

class _SalleState extends State<Salle> {
  List<dynamic> listesalles;
  List<int> listebilletpaye = [];
  TextEditingController code = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  bool security = true;
  int placecurrent = 0;
  String textToDisplay = "";
  @override
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
        title: Text("Notification Reservation"),
        content: Text("Votre reservation a ete effectuer avec succes."),
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
        title: Text('Salle de Cinema ${widget.cinemas['name']}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            )),
      ),
      body: Container(
        child: Center(
          child: this.listesalles == null
              ? CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : ListView.builder(
                  itemCount:
                      this.listesalles == null ? 0 : this.listesalles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  loadProjection(this.listesalles[index]);
                                },
                                label: Text(
                                  '           ' +
                                      this.listesalles[index]['name'],
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                icon: Icon(
                                  Icons.room_preferences_rounded,
                                  size: 30.0,
                                ),
                                style: ElevatedButton.styleFrom(
                                    onSurface: Colors.lightBlue),
                              ),
                            ),
                          ),
                          //Image.network("http://192.168.43.254:8080/imagesfilm/${this.listesalles[index]['currentprojection']['film']['id]}")
                          if (this.listesalles[index]['projection'] != null)
                            Flexible(
                              fit: FlexFit.loose,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 200.0,
                                    height: 280.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "http://192.168.43.254:8080/imagesfilm/${this.listesalles[index]['currentprojection']['film']['id']}"),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ...(this.listesalles[index]['projection']
                                              as List<dynamic>)
                                          .map(
                                        (projection) => Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: ElevatedButton(
                                            child: Text(
                                              "${projection['seance']['heureDebut']} (${projection['film']['duree']}h)Prix : ${projection['prix']}",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            style: (this.listesalles[index][
                                                            'currentprojection']
                                                        ['id'] ==
                                                    projection['id'])
                                                ? ElevatedButton.styleFrom(
                                                    primary: Colors.teal,
                                                    onPrimary: Colors.white,
                                                    onSurface: Colors.grey,
                                                  )
                                                : ElevatedButton.styleFrom(
                                                    primary: Colors.lightBlue,
                                                    onPrimary: Colors.white,
                                                    onSurface: Colors.grey,
                                                  ),
                                            onPressed: () {
                                              loadBillet(projection,
                                                  this.listesalles[index]);

                                              listebilletpaye = [];
                                              textToDisplay = "";
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (this.listesalles[index]['currentprojection'] !=
                                  null &&
                              this.listesalles[index]['currentprojection']
                                      ['billet'] !=
                                  null)
                            Flexible(
                              fit: FlexFit.loose,
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: TextField(
                                      controller: nom,
                                      decoration: InputDecoration(
                                          hintText: 'Your Name',
                                          labelText: 'Name'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    padding:
                                        EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
                                    child: TextField(
                                      obscureText: security,
                                      controller: code,
                                      maxLength: 8,
                                      decoration: InputDecoration(
                                          hintText: 'Your Code',
                                          labelText: 'Code',
                                          suffixIcon: IconButton(
                                            icon: Icon(security
                                                ? Icons.remove_red_eye
                                                : Icons.security),
                                            onPressed: () {
                                              setState(() {
                                                security = !security;
                                              });
                                            },
                                          )),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: ElevatedButton(
                                      child: Text(
                                        'Validez La Reservation',
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
                                        fieldValeur(
                                            nom.text.toString(),
                                            code.text.toString(),
                                            listebilletpaye);
                                        code.clear();
                                        nom.clear();
                                        listebilletpaye = [];
                                        textToDisplay = "";
                                        showAlertDialog(context);
                                        loadSalle();
                                      },
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: ElevatedButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'La Liste de vos Billet: ${textToDisplay}',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.teal[400],
                                        onPrimary: Colors.white,
                                        onSurface: Colors.grey,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      ...(this.listesalles[index]
                                                  ['currentprojection']
                                              ['billet'] as List<dynamic>)
                                          .map((billet) => Container(
                                                padding: EdgeInsets.all(3.0),
                                                width: 60.0,
                                                margin: EdgeInsets.only(
                                                    left: 1.0, right: 1.0),
                                                child: ElevatedButton(
                                                  child: Text(
                                                    '${billet['place']['numero']}',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      marque(
                                                          billet['place']
                                                              ['numero'],
                                                          placecurrent);
                                                    });
                                                  },
                                                  style: (billet['reserve'] ==
                                                          true)
                                                      ? ElevatedButton
                                                          .styleFrom(
                                                          primary: Colors.red,
                                                          onPrimary:
                                                              Colors.white,
                                                          onSurface:
                                                              Colors.grey,
                                                        )
                                                      : ElevatedButton
                                                          .styleFrom(
                                                          primary:
                                                              Colors.lightBlue,
                                                          onPrimary:
                                                              Colors.white,
                                                          onSurface:
                                                              Colors.grey,
                                                        ),
                                                ),
                                              )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      color: Colors.white,
                    );
                  }),
        ),
      ),
    );
  }

  @override
  void initState() {
    // qui s'execute au momment de l'initialisation de widget
    super.initState();
    loadSalle();
  }

  void loadSalle() {
    //indique l'adresse du serveur 192.168.43.254
    //localhost ne ;arche pas avec emulateur mais plutot les smartphone
    String url = this.widget.cinemas['_links']['salles']['href'];
    http.get(Uri.parse(url)).then((value) {
      //qui permet que un widget change d'etat au cours de sa vie (interaction)
      setState(() {
        listesalles = json.decode(value.body)['_embedded']['salles'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void loadProjection(listesall) {
    String url = listesall['_links']['projectionfilm']['href']
        .toString()
        .replaceAll('{?projection}', '?projection=p1');
    http.get(Uri.parse(url)).then((value) {
      if (!mounted) return;
      setState(() {
        listesall['projection'] =
            json.decode(value.body)['_embedded']['projectionFilms'];
        listesall['currentprojection'] = listesall['projection'][0];
        listesall['currentprojection']['billet'] = [];
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void loadBillet(projection, salle) {
    String url = projection['_links']['billet']['href']
        .toString()
        .replaceAll('{?projection}', '?projection=b1');
    http.get(Uri.parse(url)).then((value) {
      if (!mounted) return;
      setState(() {
        projection['billet'] = json.decode(value.body)['_embedded']['billets'];
        salle['currentprojection'] = projection;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void marque(billet, placecurrent) {
    placecurrent = billet;
    listebilletpaye.add(billet);
    textToDisplay = listebilletpaye
        .map((value) {
          String numbers = '';
          return numbers + value.toString();
        })
        .toString()
        .replaceAll(RegExp(r'([)(]*)'), "");
  }

  void fieldValeur(string, string2, listebilletpaye) {
    //return string + string2;
    String url = "http://192.168.43.254:8080/payerBillets";
    http
        .post(Uri.parse(url),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "namecustomer": string,
              "codepayer": string2,
              "listbillets": listebilletpaye
            }),
            encoding: Encoding.getByName("utf-8"))
        .then((value) {
      if (!mounted) return;
      setState(() {
        print(value.statusCode);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
