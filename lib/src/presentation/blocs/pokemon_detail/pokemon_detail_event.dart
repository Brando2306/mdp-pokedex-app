part of 'pokemon_detail_bloc.dart';

@immutable
abstract class PokemonDetailEvent {}

class GetPokemonDetailEvent extends PokemonDetailEvent {
  final int id;
  GetPokemonDetailEvent(this.id);
}