import 'package:flutter/material.dart';
import 'package:frontend/screens/Home98.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseGame extends StatefulWidget {
  const ChooseGame({Key? key}) : super(key: key);

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            titleSection(),
            gameSection(context),
            gameSection(context),
            gameSection(context),
            gameSection(context),

          ],
        ),

      ),
    );
  }
}

Widget gameSection(BuildContext context){
  return InkWell(
    onTap:() {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home98(),
        ),
      );
    },
    child: Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(20),
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Colors.amber,
              Color.fromARGB(255, 218, 150, 60),

            ])
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/Card.png'),

          ],
        )
    ),
  );

}


Widget titleSection(){
  return Container(
      padding: EdgeInsets.all(20),
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Sélectionner le moyen de biture!",
            style: GoogleFonts.oswald(
               textStyle: TextStyle(fontSize: 22 ),


          ),
          ),
        ],
      )
  );
}