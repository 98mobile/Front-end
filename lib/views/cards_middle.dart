import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';

import '../views/playing_card.dart';

class CardsMiddle extends StatefulWidget {
  final String cardValue;

  const CardsMiddle(this.cardValue, {Key? key}) : super(key: key);

  @override
  State<CardsMiddle> createState() => _CardsMiddleState();
}

class _CardsMiddleState extends State<CardsMiddle> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    var lc= roomDataProvider.roomData['lastCard'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 120,
          child: PlayingCard(lc),
        ),
        SizedBox(width: 10,),
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: const Color.fromARGB(200, 229, 208, 204),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child:AspectRatio(
    aspectRatio: 50 / 100,
    child: FittedBox(
    fit: BoxFit.cover,
    child: Row(
    children: [
          Image.asset(
            'assets/images/Card.png',
            width: 70,
            height: 110,
            fit: BoxFit.cover,
          ),
      SizedBox(height: 10,)
    ],
    ),
    ),
          ),
        ),
      ],
    );
  }


}
