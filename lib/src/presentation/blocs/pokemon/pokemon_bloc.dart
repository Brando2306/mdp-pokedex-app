import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:mdp_pokedex_app/src/data/api/api.dart';
import 'package:mdp_pokedex_app/src/domain/models/pokemon_model.dart';
import 'package:mdp_pokedex_app/src/presentation/common/helpers/helpers.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final Api _api = Api();
  
  PokemonBloc() : super(PokemonInitialState()) {

    on<GetPokemonsEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final pokemons = await _api.getPokemons();
        final newPokemonList = pokemons.results.map((result) {
          final id = PokemonHelper.formatPokemonId(result);
          final idName = PokemonHelper.formatIdNumber(id);
          final picture = PokemonHelper.formatImage(id);
          final name = PokemonHelper.formatCapitalizeName(result.name);

          return SimplePokemon(id: id, idName: idName, name: name, picture: picture);
        }).toList();
        emit(PokemonLoadedState(newPokemonList, newPokemonList, SortBy.id, ''));
      } catch (e) {
        emit(PokemonErrorState('Error al obtener la lista Pokemons.'));
      }
    });

    on<SortPokemonsEvent>((event, emit) async {
      final currentState = state;
      if (currentState is PokemonLoadedState) {
        List<SimplePokemon> sortedPokemonList = currentState.pokemons;
        
        switch (event.sortBy) {
          case SortBy.id:
            sortedPokemonList.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
            break;
          case SortBy.name:
            sortedPokemonList.sort((a, b) => a.name.compareTo(b.name));
            break;
        }

        if(event.query.isNotEmpty){
          final filteredPokemonList = sortedPokemonList.where((pokemon) {
            final pokemonName = pokemon.name.toLowerCase();
            return pokemonName.contains(event.query.toLowerCase());
          }).toList();
          sortedPokemonList = filteredPokemonList;
        }

        emit(PokemonLoadedState(currentState.pokemons, sortedPokemonList, event.sortBy, event.query));
      }
    });
  }
}
