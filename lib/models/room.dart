import 'package:mp_tictactoe/models/player.dart';

class Room {
  final String occupancy;
  final String id;
  final List players;
  final List Listcards;
  final bool isStart;
  final int maxScore;
  final int currentScore;
   Player turn;
   Player menBefore;
  final int turnIndex;
  final String lastCard;
  

  Room({
    required this.id,
    required this.players,
    required this.Listcards,
    required this.isStart,
    required this.occupancy,
    required this.maxScore,
    required this.turn,
    required this.menBefore,
    required this.turnIndex,
    required this.lastCard,
    required this.currentScore,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'players': players,
    'Listcards': Listcards,
    'isStart': isStart,
    'occupancy': occupancy,
    'maxScore': maxScore,
    'maxScore': maxScore,
    'turn': turn,
    'menBefore': menBefore,
    'turnIndex': turnIndex,
    'lastCard': lastCard,
    'currentScore': currentScore,
  };
}