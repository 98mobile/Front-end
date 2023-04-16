import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/game_methods.dart';
import 'package:mp_tictactoe/resources/socket_client.dart';
import 'package:mp_tictactoe/screens/game_screen.dart';
import 'package:mp_tictactoe/utils/utils.dart';
import 'package:mp_tictactoe/views/waiting_lobby.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods with WidgetsBindingObserver  {

  //implémenter le disconnect automatique

  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void disconnect(String roomId, String nickname) {
    _socketClient.emit('disconnect', {
      'roomId': roomId,
      'nickname': nickname,
    });
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void startGame(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('start', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }


  //modifier pour renvoyer la carte sélectionné
  //choosecard
  void chooseCard(String valeur, String roomId) {
    if (valeur.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('tap', {
        'valeur': valeur,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      print('ok');
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void startGameSuccessListener(BuildContext context) {
    _socketClient.on('startGameSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  /// ********************************
  /// A modifier
  /// met à jour le tour des coueurs
  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );

    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);

    });
  }

  ///update apres que l'info soit passé par la back-end
  ///modifier pour augmenter le score de la gagme + check défaite
  ///ecoute 'choosedCard'
  void choosedCardListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      //appel à la meme fonction
     /* roomDataProvider.updateDisplayElements(
        data['valeur'],
        data['famille'],
      );*/
      roomDataProvider.updateRoomData(data['room']);
      // check Loser
      GameMethods().checkLooser(context, _socketClient);
    });
  }

  //ok renvoie à l'acceuil
  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['nickname']} a perdu !');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
