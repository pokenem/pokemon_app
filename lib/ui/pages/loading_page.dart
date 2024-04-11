import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Gif(
          autostart: Autostart.loop,
          image: const AssetImage('assets/pikachu-happy.gif'),
          width: 115,
        ),
      ),
    );
  }
}
