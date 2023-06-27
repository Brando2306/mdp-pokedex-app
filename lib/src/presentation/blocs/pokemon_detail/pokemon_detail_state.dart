part of 'pokemon_detail_bloc.dart';

@immutable
abstract class PokemonDetailState {}

class PokemonDetailInitialState extends PokemonDetailState {}

class PokemonDetailLoadingState extends PokemonDetailState {}

class PokemonDetailLoadedState extends PokemonDetailState {
  final PokemonFull pokemon;
  PokemonDetailLoadedState(this.pokemon);
}

class PokemonDetailErrorState extends PokemonDetailState {
  final String errorMessage;
  PokemonDetailErrorState(this.errorMessage);
}

