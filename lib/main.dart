import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:frontend/screens/ChooseGame.dart';



TextEditingController _textController = TextEditingController();


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nineeight',
      routes: {

        // When navigating to the "/second" route, build the SecondScreen widget.
        '/chooseGame': (context) => const ChooseGame(),
      },

      home: Welcome(),
    );
  }
}

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 244, 8, 209),
              Color.fromARGB(255, 158, 24, 138),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Card.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Entrez votre nom de jeu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: barreDeSaisie,
            ),
            const SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Bouton(context),)
          ],
        ),
      )),
    );
  }
}

Widget barreDeSaisie = Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: const Color.fromARGB(255, 255, 255, 255),
  ),
  child: TextField(
    controller: _textController,
  ),
);

//192.168.1.168
final String _url = 'http://192.168.1.168:5000/post/createUser';
String role=  ' vide';
Widget Bouton(BuildContext context) {
  return Container(

    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color:  const Color.fromARGB(255, 255, 255, 255),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(elevation: 2),
      onPressed: () async {
        final response = await Dio().post(
          _url,
          data: jsonEncode(<String, String>{
            'username': _textController.text,
            'role': role,
          }),
        );

        if (response.statusCode == 200) {
          print("Post successfully created.");
        } else {
          print("Failed to create post.");
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChooseGame(),
          ),
        );
      },
      child:  const Text('Valider'),
    ),
  );
}
Widget Texte = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color:  const Color.fromARGB(255, 255, 255, 255),
    ),
    child: Row(children: [
      TextField(
        controller: _textController,
        decoration: const InputDecoration(
          labelText: "Enter your text here",
        ),
      ),
    ]));


