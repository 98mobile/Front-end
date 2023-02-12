import 'package:flutter/material.dart';
import 'package:frontend/screens/98/CreerScreen.dart';
import 'package:frontend/screens/98/RegleScreen.dart';
import 'package:frontend/screens/98/RejoindreScreen.dart';
import 'package:google_fonts/google_fonts.dart';


class Home98 extends StatefulWidget {
  const Home98({Key? key}) : super(key: key);

  @override
  State<Home98> createState() => _Home98State();
}

class _Home98State extends State<Home98> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            titleSection(),
            regleSection(context),
            rowSection(context),
            //creerSection(context),
            //rejoindreSection(context),

          ],

        ),
      ),

    );
  }
}

Widget regleSection(BuildContext context){
  return InkWell(
    onTap:() {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegleScreen(),
        ),
      );
    },
    child: Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(35),
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
            Text("Regles", style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 40)),),

          ],
        )
    ),
  );

}

Widget rowSection(BuildContext context){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Creer(context),
          Rejoindre(context),
                ],
              )
          );
}

Widget Creer(BuildContext context){

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreerScreen(),
        ),
      );
    },
    child:Container(
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
            Text("Créer", style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 30)),),

          ],
        )
    ),
  );
}

Widget Rejoindre(BuildContext context){

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RejoindreScreen(),
        ),
      );
    },
    child:Container(
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
            Text("Rejoindre", style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 30)),),

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
          Text("Bienvenue dans le 98!",
            style: GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 22 ),


            ),
          ),
        ],
      )
  );
}