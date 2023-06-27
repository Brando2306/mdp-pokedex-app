part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

//Pokemon List
class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<SimplePokemon> pokemons;
  final List<SimplePokemon> sortedPokemons;
  final SortBy sortBy;
  final String query;
  PokemonLoadedState(this.pokemons, this.sortedPokemons, this.sortBy, this.query);
}

class PokemonErrorState extends PokemonState {
  final String errorMessage;
  PokemonErrorState(this.errorMessage);
}