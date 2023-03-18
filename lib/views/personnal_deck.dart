import 'dart:io';
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

  Player findPlayerBySocketID(List<dynamic> players, String socketID) {
    List<Player> playerList = players.map((playerData) => Player.fromMap(playerData)).toList();
    try {
      Player player = playerList.firstWhere((player) => player.socketID == socketID);
      return player;
    } catch (e) {
      print("Player with socketID $socketID not found");
      return Player(nickname: 'nickname', socketID: 'socketID', card1: 'card1', card2: 'card2', card3: 'card3', card4: 'card4', playerType: 1);
    }
  }


  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    String? socketId = _socketMethods.socketClient.id; // Replace with the actual socket ID

    if (roomDataProvider.roomData.isNotEmpty &&
        roomDataProvider.roomData.containsKey('room') &&
        roomDataProvider.roomData['room'].containsKey('players')) {
      Player player = findPlayerBySocketID(roomDataProvider.roomData['room']['players'], socketId!);

      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayingCard(player.card1),
            SizedBox(width: 10),
            PlayingCard(player.card2),
            SizedBox(width: 10),
            PlayingCard(player.card3),
            SizedBox(width: 10),
            PlayingCard(player.card4),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting for data
    }

  }
}

