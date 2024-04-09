import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/ui/pages/pokemon_info_page.dart';
import 'package:get_it/get_it.dart';

import '../../domain/main_bloc.dart';
import '../../domain/main_state.dart';
import 'main_page.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {GetIt.I.registerSingleton(MainBloc());}
  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I<MainBloc>();
    return BlocProvider<MainBloc>(
      create: (context) => bloc,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainStateLoading) {
            return Center(
              child: GestureDetector(
                onTap: (){bloc.changeState(MainStateError(error: "good"));},
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ),
            );
          } else if (state is MainStateError) {
            return Center(
              child: GestureDetector(
                onTap: (){bloc.changeState(MainStateLoading());},
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          } else if(state is MainStateList){
            return MainPage();
          } else if(state is MainStateInfo){
            return PokemonInfoPage();
          }
          print(state);
          return Center(child: Text('Что-то пошло не так'));
        },
      ),
    );
  }
}
