import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:mp_tictactoe/views/cards_middle.dart';
import 'package:mp_tictactoe/views/game_info.dart';
import 'package:mp_tictactoe/views/personnal_deck.dart';
import 'package:mp_tictactoe/views/playing_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/Game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]
    );
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.endGameListener(context);
  }
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: GameInfo(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: CardsMiddle('Rco'),
              ),
            ),
            Expanded(
              flex: 2,
              child: PersonnalDeck(),
            ),
          ],
        ),
      ),
    );
  }


}
