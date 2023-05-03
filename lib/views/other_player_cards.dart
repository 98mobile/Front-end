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

class OtherPlayerCards extends StatefulWidget {
  String playerName;
   OtherPlayerCards({Key? key, required this.playerName}) : super(key: key);

  @override
  State<OtherPlayerCards> createState() => _OtherPlayerCardsState();
}

class _OtherPlayerCardsState extends State<OtherPlayerCards> {
  final SocketMethods _socketMethods = SocketMethods();

  late RoomDataProvider? room;


  @override
  void initState() {
    super.initState();
    room = Provider.of<RoomDataProvider>(context, listen: false);
  }
  
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    String playerTurn = "";
    if (roomDataProvider.roomData.containsKey('turn') && roomDataProvider.roomData['turn'] != null && roomDataProvider.roomData['turn'].containsKey('nickname')) {
      playerTurn = roomDataProvider.roomData['turn']['nickname'];
    }

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text(widget.playerName),
        ],
      ),
    );
  }
}
