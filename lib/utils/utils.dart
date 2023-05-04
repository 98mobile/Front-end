import 'package:flutter/material.dart';
import 'package:mp_tictactoe/resources/game_methods.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';
import '../screens/main_menu_screen.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showGameDialog(BuildContext context, String text) {

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Text(text + " a perdu!");
                Navigator.pushNamed(context, MainMenuScreen.routeName);
              },
              child: const Text(
                'Play Again',
              ),
            ),
          ],
        );
      });
}
