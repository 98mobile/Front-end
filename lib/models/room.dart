import 'package:mp_tictactoe/models/player.dart';

class Room {
  final String occupancy;
  final String id;
  final List players;
  final bool isStart;
  final int maxScore;
  final int currentScore;
   Player turn;
  final int turnIndex;
  final String lastCard;
  

  Room({
    required this.id,
    required this.players,
    required this.isStart,
    required this.occupancy,
    required this.maxScore,
    required this.turn,
    required this.turnIndex,
    required this.lastCard,
    required this.currentScore,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'players': players,
    'isStart': isStart,
    'occupancy': occupancy,
    'maxScore': maxScore,
    'maxScore': maxScore,
    'turn': turn,
    'turnIndex': turnIndex,
    'lastCard': lastCard,
    'currentScore': currentScore,
  };
}