import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

import '../../domain/main_bloc.dart';

class LoadingPage extends StatelessWidget {
  final String backUrl;
  final String loadingName;
  const LoadingPage(
      {Key? key, required this.backUrl, required this.loadingName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<MainBloc>(context).loadMain(backUrl);
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Gif(
            autostart: Autostart.loop,
            image: const AssetImage('assets/pikachu-happy.gif'),
            width: 115,
          ),
        ),
      ),
    );
  }
}
