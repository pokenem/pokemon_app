import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/ui/pages/pokemon_info_page.dart';

import '../../domain/main_bloc.dart';
import '../../domain/main_state.dart';
import 'main_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = MainBloc();
    return BlocProvider<MainBloc>(
      create: (context) => bloc,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainStateLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          } else if (state is MainStateError) {
            return const Center(child: Text('Что-то пошло не так'));
          } else if(state is MainStateList){
            return MainPage();
          } else if(state is MainStateInfo){
            return PokemonInfoPage();
          }
          return const Center(child: Text('Что-то пошло не так'));
        },
      ),
    );
  }
}
