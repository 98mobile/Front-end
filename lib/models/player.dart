class Player {
  final String nickname;
  final String socketID;
   String card1 ='';
   String card2 ='';
   String card3 = '';
   String card4 = '';
   final int playerType;

  Player({
    required this.nickname,
    required this.socketID,
    required this.card1,
    required this.card2,
    required this.card3,
    required this.card4,
    required this.playerType,
  });


  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'card1' : card1,
      'card2' : card2,
      'card3' : card3,
      'card4' : card4,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      card1: map['card1'] ?? '',
      card2: map['card2'] ?? '',
      card3: map['card3'] ?? '',
      card4: map['card4'] ?? '',
      playerType: map['playerType'] ?? '',
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    String? card1,
    String? card2,
    String? card3,
    String? card4,
    int? playerType,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      card1: card1 ?? this.card1,
      card2: card2 ?? this.card2,
      card3: card3 ?? this.card3,
      card4: card4 ?? this.card4,
      playerType: playerType ?? this.playerType,
    );


  }
}
