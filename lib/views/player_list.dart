import 'dart:io';
import 'package:mp_tictactoe/views/other_player_cards.dart';
import 'package:mp_tictactoe/widgets/custom_text.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mp_tictactoe/resources/socket_client.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';
import 'package:mp_tictactoe/views/playing_card.dart';
import '../models/player.dart';
import '../provider/room_data_provider.dart';
import 'game_info.dart';

class PlayerList extends StatefulWidget {
   final List players;
  const  PlayerList( {Key? key, required this.players}) : super(key: key);

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  final SocketMethods _socketMethods = SocketMethods();

  late RoomDataProvider? room;


  @override
  void initState() {
    super.initState();
    room = Provider.of<RoomDataProvider>(context, listen: false);
  }

  Color hexColor(String colorHexCode) {
    String newColorString = '0xff' + colorHexCode.replaceAll('#', '');
    int colorInt = int.parse(newColorString);
    return Color(colorInt);
  }

  numberPlayers(List players){
    return players.length;
  }


  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    List players = roomDataProvider.roomData['players'];
    print("##################La liste des joueurs " + players.toString());

    /* variables */
    Color color = hexColor("6689A1");
    Color fond = hexColor("292F36");
    Color allbox = hexColor("8D8E8E");
    var nombre= numberPlayers(players);


    return Container(
      height: 200,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: allbox,
          ),
        child:
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5,),
              TitleListe(color, fond),
              for (int i = 0; i< nombre; i++)  OtherPlayerCards(playerName: players[i]['nickname'])

      ],
          ),
        ),

    );
  }
}


Widget TitleListe(Color colorTexte, Color fond) {
  return Container(
    width: 90,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: fond,
    ),
    child: Text(
      "Liste des joueurs",
      style: TextStyle(fontSize: 10, color: colorTexte),

    ),
  );
}