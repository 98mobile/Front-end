import 'dart:io';
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

class PersonnalDeck extends StatefulWidget {
  const PersonnalDeck({Key? key}) : super(key: key);

  @override
  State<PersonnalDeck> createState() => _PersonnalDeckState();
}

class _PersonnalDeckState extends State<PersonnalDeck> {
  final SocketMethods _socketMethods = SocketMethods();
  var playerMe = null;

  late RoomDataProvider? room;

  @override
  void initState() {
    super.initState();
    room = Provider.of<RoomDataProvider>(context, listen: false);
    findPlayerMe(room!);
  }

  findPlayerMe(RoomDataProvider room) {
    print ('search');
    room.roomData['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
        print("playerme = "+playerMe.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    findPlayerMe(roomDataProvider);
    print(playerMe);
    Map<String, dynamic> playerData = playerMe as Map<String, dynamic>;
    String card1 = playerData['card1'] ?? '';
    String card2 = playerData['card2'] ?? '';
    String card3 = playerData['card3'] ?? '';
    String card4 = playerData['card4'] ?? '';



    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          PlayingCard(card1),
          SizedBox(width: 10),
          PlayingCard(card2),
          SizedBox(width: 10),
          PlayingCard(card3),
          SizedBox(width: 10),
          PlayingCard(card4),
        ],
      ),
    );
  }
}
