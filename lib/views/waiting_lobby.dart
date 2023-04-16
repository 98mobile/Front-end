import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/screens/join_room_screen.dart';
import 'package:mp_tictactoe/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../resources/socket_methods.dart';
import '../widgets/custom_button.dart';

class WaitingLobby extends StatefulWidget {
  static String routeName = '/Waiting';
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {

  final SocketMethods _socketMethods = SocketMethods();

  late TextEditingController roomIdController;
  late TextEditingController roomIdController2;

  JoinRoomScreen get joinRoomScreen => JoinRoomScreen();

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    );
    roomIdController2 = TextEditingController(
      text:
      Provider.of<RoomDataProvider>(context, listen: false).roomData['nickname'],
    );
    _socketMethods.startGameSuccessListener(context);

  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  void startGame(BuildContext context) {
    Navigator.pushNamed(context, '/Game');
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);


    return Scaffold(
      body:
       SingleChildScrollView(
          child: Column(
              children :
              [
                const SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(20),
                  height: 120,
                  child: Column(
                    children: [
                      CustomButton(
                        onTap: () =>
                            _socketMethods.startGame(
                                roomDataProvider.roomData['turn']['nickname'],
                                roomDataProvider.roomData['_id']
                            ),
                        text: 'Lancer le jeu',
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const Text('ID de salle'),
                SizedBox(height: 20),
                CustomTextField(
                  controller: roomIdController,
                  hintText: '',
                  isReadOnly: true,
                ),

                SizedBox(height: 10),

              ]
          ),
       ),

    );
  }
}

Widget player1(TextEditingController roomIdController,RoomDataProvider roomDataProvider ){
  return
     Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(40),
        height: 40,
        decoration: BoxDecoration(
        ),
        child: CustomTextField(
          controller: roomIdController,
          hintText:  roomDataProvider.player1.socketID,
          isReadOnly: true,
        ),
    );


}

Widget player2(TextEditingController roomIdController,RoomDataProvider roomDataProvider ){
  return InkWell(
    child: Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.all(20),
      height: 20,
      decoration: BoxDecoration(
      ),
      child: CustomTextField(
        controller: roomIdController,
        hintText:  roomDataProvider.player2.nickname,
        isReadOnly: true,
      ),
    ),
  );

}


