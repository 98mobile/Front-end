import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethods {

  void checkLooser(BuildContext context, Socket socketClent) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String looser = '';

    //check le score et le tour pour pouvoir désigner le perdant

    if (looser != '') {
      if (roomDataProvider.player1.playerType == looser) {
        showGameDialog(context, '${roomDataProvider.player1.nickname} loose!');
        socketClent.emit('looser', {
          'looserSocketId': roomDataProvider.player1.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    //remettre l'affichage à zero

    roomDataProvider.setCardsto0();
  }
}
