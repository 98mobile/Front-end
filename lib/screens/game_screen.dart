import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:mp_tictactoe/views/cards_middle.dart';
import 'package:mp_tictactoe/views/game_info.dart';
import 'package:mp_tictactoe/views/other_player_cards.dart';
import 'package:mp_tictactoe/views/personnal_deck.dart';
import 'package:mp_tictactoe/views/player_list.dart';
import 'package:mp_tictactoe/views/playing_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../resources/socket_client.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import 'main_menu_screen.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/Game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}
class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  late TextEditingController scoreControl;
  var playerMe = null;

  ValueNotifier<bool> _roiPopNotifier = ValueNotifier(false);
  ValueNotifier<bool> _looserNotifier = ValueNotifier(false);


  void _roiPopListener() {
    _roiPopNotifier.addListener(() {
      if (_roiPopNotifier.value) {
        Future.delayed(Duration.zero, () {
          _openRoiPopDialog();
          _roiPopNotifier.value = false;
        });
      }
    });
  }

  void _looserListener() {
    _socketMethods.isLooserNotifier.addListener(() {
      if (_socketMethods.isLooserNotifier.value) {
        Future.delayed(Duration.zero, () {
          _looserDialog(context);
          _socketMethods.setIsLooser(false); // Reset the isLooser value
        });
      }
    });
  }




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
    _socketMethods.endGameListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.roiListener(context);
    scoreControl = TextEditingController();

    _roiPopListener();
    _looserListener();
  }



  @override
  void dispose() {
    scoreControl.dispose();
    super.dispose();
  }

  findPlayerMe(RoomDataProvider room) {
    room.roomData['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    List players = roomDataProvider.roomData['players'];
    findPlayerMe(roomDataProvider);

    //c'est le gars d'après qui joue
    if (_socketMethods.roiPopReceived && playerMe['nickname'] == roomDataProvider.roomData['menBefore']['nickname']) {
      _socketMethods.togglePop();
      _roiPopNotifier.value = true;
    }

    if (_socketMethods.isLooserNotifier == true ){
      print("looser");
        _socketMethods.toggleFin();
        _looserNotifier.value= true;
        print("looser2");
    }

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
              child: Row(
                children: [
                  PlayerList(
                    players: players,
                  ),
                  SizedBox(
                    height: 150,
                    width: 300,
                  ),
                  CardsMiddle('Rco'),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
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

  Future _openRoiPopDialog() async {

    FocusNode scoreFocusNode = FocusNode();
    int? score = await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text( "Choisis le score!"),
          content: TextField(
            controller: scoreControl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            focusNode: scoreFocusNode,
          ),
          actions: [
            CustomButton(
                onTap: () {
                  int parsedScore = int.tryParse(scoreControl.text) ?? 0;
                  if (parsedScore >= 0 && parsedScore <= 98) {
                    Navigator.of(context).pop(parsedScore);
                  } else {
                    showSnackBar(
                        context, 'Entrez un score valide entre 0 et 98.');
                  }
                },
                text: 'Valider')
          ],
        ));

    // Ajoutez cette ligne pour donner le focus au TextField lorsque la boîte de dialogue s'ouvre
    scoreFocusNode.requestFocus();

    if (score != null) {
      _socketMethods.score(
          score.toString(), _socketMethods.getRoomId(context));
    }
  }

  //'${roomDataProvider.roomData['looserNickname']}'
  Future _looserDialog(BuildContext context) async {
   // RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    FocusNode scoreFocusNode = FocusNode();
    int? score = await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text( "Ce connard a perdu!"),
          content: Text(
            "Pour lancer une nouvelle partie cliquer sur le bouton!"
          ),
          actions: [
            CustomButton(
                onTap: () {
                    Navigator.pushNamed(context, MainMenuScreen.routeName);
                },
                text: 'Valider')
          ],
        ));
  }

}
