import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class PlayingCard extends StatefulWidget {
  final String cardValue;

  const PlayingCard(this.cardValue, {Key? key}) : super(key: key);

  @override
  State<PlayingCard> createState() => _PlayingCardState();
}

class _PlayingCardState extends State<PlayingCard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  @override
  Widget build(BuildContext context) {
    IconData iconData;
    String value;
    String family;
    Color color;


    if(widget.cardValue.length >= 3 ){
    String lastTwoChars = widget.cardValue.substring(widget.cardValue.length - 2);
    String valueStr = widget.cardValue.substring(0, widget.cardValue.length - 2);


      switch (lastTwoChars){
        case 'pi':
          family = '♠';
          color = Colors.black;
          break;
        case 'co':
          family = '♥';
          color = Colors.red;
          break;
        case 'ca':
          family = '♦';
          color = Colors.red;
          break;
        case 'tr':
          family = '♣';
          color = Colors.black;
          break;
        default:
          family = '';
          color = Colors.black;
          break;
      }

      switch (valueStr) {
        case 'V':
          value = 'J';
          break;
        case 'D':
          value = 'Q';
          break;
        case 'R':
          value = 'K';
          break;
        case '10':
          value = '10';
          break;
        default:
          value = valueStr;
          break;
      }
    }
   else {
     value = '';
     family = '';
     color = Colors.black;
   }

    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 10, color: color),
          ),
          Text(
            family,
            style: TextStyle(
              fontSize: 20,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}