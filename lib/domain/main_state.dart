class MainState{
  const MainState();
}

class MainStateError extends MainState{
  final String error;
  const MainStateError({required this.error});
}

class MainStateLoading extends MainState{
  const MainStateLoading();
}

class MainStateInfo extends MainState{
  final String poke;
  const MainStateInfo({required this.poke});
}

class MainStateList extends MainState{
  final List<String> pokemons;
  const MainStateList({required this.pokemons});
}