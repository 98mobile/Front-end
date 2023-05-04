import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_client.dart';
import 'package:mp_tictactoe/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethods {
  var playerMe = null;

  findPlayerMe(RoomDataProvider room) {
    room.roomData['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
      }
    });
  }

  getValueStr(String card) {
    String valueStr = card.substring(0, card.length - 2);
    return valueStr;
  }

  getValue(String card) {
    String valueStr = card.substring(0, card.length - 2);
    valueStr = int.parse(valueStr) as String;
    return valueStr;
  }


}
