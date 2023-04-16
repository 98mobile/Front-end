import 'package:flutter/material.dart';
import 'package:mp_tictactoe/models/player.dart';
import 'package:mp_tictactoe/resources/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/room.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  String? _currentUserSocketID;


  Player _player1 = Player(
    nickname: '',
    socketID: '',
    card1: '',
    card2: '',
    card3: '',
    card4: '',
    playerType: 1,
  );

  Player _player2 = Player(
    nickname: '',
    socketID: '',
    card1: '',
    card2: '',
    card3: '',
    card4: '',
    playerType: 2,
  );

 /* Room _room = Room (
    id: '',
    players: [],
    isStart: false,
    occupancy: '',
    maxScore: 98,
    turnIndex: 1,
    lastCard: '',
    currentScore: 0,
    turn: Player(soc),
  );*/



  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  int get filledBoxes => _filledBoxes;
  Player get player1 => _player1;
  Player get player2 => _player2;
  String? get currentUserSocketID => _currentUserSocketID;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }


  void setCurrentUserSocketID(String socketID) {
    _currentUserSocketID = socketID;
    notifyListeners();
  }

  void updateDisplayElements(int value, String famille) {

  }
  Player findPlayerBySocketID(IO.Socket socket) {
    List<dynamic> playersData = roomData['room']['players'];
    List<Player> players =
    playersData.map((playerData) => Player.fromMap(playerData)).toList();

    try {
      Player player = players.firstWhere((player) => player.socketID == socket);
      return player;
    } catch (e) {
      print("Player with socketID ${socket.id} not found");
      return Player(
        nickname: 'nickname',
        socketID: 'socketID',
        card1: 'card1',
        card2: 'card2',
        card3: 'card3',
        card4: 'card4',
        playerType: 1,
      );
    }
  }



  void setCardsto0() {

  }
}
