import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_state.dart';

class MainBloc extends Cubit<MainState> {
  MainBloc() : super(MainStateLoading());
  void changeState(MainState state){
      emit(state);
  }
}