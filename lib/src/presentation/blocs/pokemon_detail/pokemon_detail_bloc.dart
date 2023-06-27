import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:mdp_pokedex_app/src/data/api/api.dart';
import 'package:mdp_pokedex_app/src/domain/models/pokemon_model.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final Api _api = Api();
  
  PokemonDetailBloc() : super(PokemonDetailInitialState()) {
    on<GetPokemonDetailEvent>((event, emit) async {
      emit(PokemonDetailLoadingState());
      try {
        final pokemon = await _api.getPokemonDetail(event.id);
        emit(PokemonDetailLoadedState(pokemon));
      } catch (e) {
        emit(PokemonDetailErrorState('Error al obtener el detalle del Pokemon.'));
      }
    });

  }
}
