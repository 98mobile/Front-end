import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/game_methods.dart';
import 'package:mp_tictactoe/resources/socket_client.dart';
import 'package:mp_tictactoe/screens/game_screen.dart';
import 'package:mp_tictactoe/utils/utils.dart';
import 'package:mp_tictactoe/views/waiting_lobby.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/player.dart';

class SocketMethods with WidgetsBindingObserver  {

  //implémenter le disconnect automatique

  final _socketClient = SocketClient.instance.socket!;
  bool roiPopReceived = false;
  bool isFin =false;
  ValueNotifier<bool> isLooserNotifier = ValueNotifier(false);  late Player looser ;

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
  
  void score(String score, String roomId){
    _socketClient.emit('newScoreRoi', {
      'value':  score,
      'roomId': roomId
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
  void chooseCard(String valeur, String roomId, String socketId) {
    if (valeur.isNotEmpty &&  roomId.isNotEmpty ) {
      _socketClient.emit('tap', {
        'valeur': valeur,
        'roomId': roomId,
        'socketId': socketId,
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

  void roiListener(BuildContext context) {
    _socketClient.on('roiPop', (data) {

          roiPopReceived = true;
    });
    print("on a recu roiPop");
  }

  void togglePop() {
    roiPopReceived = !roiPopReceived;
  }
  void toggleFin(){
    isFin = !isFin;
  }

  void setIsLooser(bool value) {
    isLooserNotifier.value = value;
  }



  ///update apres que l'info soit passé par la back-end
  ///modifier pour augmenter le score de la gagme + check défaite
  ///ecoute 'choosedCard'
  void choosedCardListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      print("##################################### \n");
      print(" data room " + data['room'].toString());

      Provider.of<RoomDataProvider>(context, listen: false)
      .updateRoomData(data['room']);


      // check Loser
      //GameMethods().checkLooser(context, _socketClient);
    });
  }

  String getRoomId(BuildContext context){

    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
    var roomId= roomDataProvider.roomData['_id'];
    return roomId;
  }

  //ok renvoie à l'acceuil
  void endGameListener(BuildContext context) {
    print("on a recu endGame");
    _socketClient.on('endGame', (playerData) {
      isFin = true;
      print("Inside endGame listener"); // Debugging print statement
      setIsLooser(true);
    });
  }



}
