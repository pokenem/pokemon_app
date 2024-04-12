import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/main_bloc.dart';

class ErrorPage extends StatelessWidget {
  final String error;
  final String retryUrl;
  final String backUrl;
  final String retryName;

  const ErrorPage(
      {Key? key,
      required this.error,
      required this.retryUrl,
      required this.retryName,
      required this.backUrl})
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_off_rounded,
                color: Colors.black,
                size: 70,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                error,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              IconButton(
                  iconSize: 70,
                  color: Colors.black,
                  onPressed: () {
                    if (retryName == 'main') {
                      BlocProvider.of<MainBloc>(context).loadMain(retryUrl);
                    } else if (retryName == 'info') {
                      BlocProvider.of<MainBloc>(context).loadInfo(retryUrl);
                    }
                  },
                  icon: const Icon(Icons.update_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
