import 'package:flutter/material.dart';

class Conteneur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //conteneur de page d'accueil

    return Container(
      //pour utilise image a l'interieur d'un conteneur il faut donne la taille

      child: Column(
        children: [
          Divider(
            thickness: 0.1,
          ),
          //divide pour l'espace

          Container(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
            margin: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: 'Nous Aufrons les Meilleurs Services',
                        hoverColor: Colors.blue,
                        enabled: false),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.5,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  print('Appel video');
                },
                icon: Icon(
                  Icons.videocam,
                  color: Colors.red,
                  size: 37.0,
                ),
                label: Text(
                  'Live',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              VerticalDivider(
                width: 8.0,
              ),
              TextButton.icon(
                onPressed: () {
                  print('Photo');
                },
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.green,
                  size: 37.0,
                ),
                label: Text(
                  'Photo',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              VerticalDivider(
                width: 8.0,
              ),
              TextButton.icon(
                onPressed: () {
                  print('Appel video');
                },
                icon: Icon(
                  Icons.video_call,
                  color: Colors.purpleAccent,
                  size: 37.0,
                ),
                label: Text(
                  'Room',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              VerticalDivider(
                width: 8.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 37.0,
                ),
                onPressed: () {},
                color: Colors.blue,
              ),
            ],
          ),
          Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          Card(
            child: Image.asset("./images/logo1.png"),
          ),
          Container(
            color: Colors.grey[800],
            margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Flexible(
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Text(
                    'CONTACT :*',
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.contact_phone),
                            iconSize: 30.0,
                            color: Colors.white,
                          ),
                          Text(
                            '773722478 *',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.contact_mail),
                            iconSize: 30.0,
                            color: Colors.white,
                          ),
                          Text(
                            'cinmagic.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // pour utilise les widgets il faut bien regarde leur parametre si
      // il retourne un widget alors on prend les instances point les variable
      //en gernerales les nom des instances termine par s sinon on declare l'attribut
      //widget et puis deux point on appelle le construsteur de de widget
    );
  }
}
