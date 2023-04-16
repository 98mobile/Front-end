import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class GameInfo extends StatefulWidget {
  const GameInfo({Key? key}) : super(key: key);

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
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

    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('${roomDataProvider.roomData['turn']['nickname']}' " est en train de jouer..."),
            Text(
              "Score : " '${roomDataProvider.roomData['currentScore']}',
            ),
          ],
        ),
      ),
    );
  }

}
