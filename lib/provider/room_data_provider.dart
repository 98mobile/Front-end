import 'package:flutter/material.dart';
import 'package:mp_tictactoe/models/player.dart';

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

  void setCardsto0() {

  }
}
