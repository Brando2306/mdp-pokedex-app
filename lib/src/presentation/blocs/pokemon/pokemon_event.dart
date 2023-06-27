part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemonsEvent extends PokemonEvent {}

class SortPokemonsEvent extends PokemonEvent {
  final SortBy sortBy;
  final String query;
  SortPokemonsEvent(this.sortBy, this.query);
}

enum SortBy {
  id,
  name,
}
