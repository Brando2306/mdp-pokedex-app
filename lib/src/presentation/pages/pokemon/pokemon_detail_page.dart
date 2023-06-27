import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mdp_pokedex_app/src/presentation/blocs/blocs.dart';
import 'package:mdp_pokedex_app/src/presentation/pages/pokemon/widgets/widgets.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.id});
  final int id;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  void initFunctions() {
    final pokemonBloc = BlocProvider.of<PokemonDetailBloc>(context, listen: false);
    pokemonBloc.add(GetPokemonDetailEvent(widget.id));
  }

  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }

  BlocBuilder<PokemonDetailBloc, PokemonDetailState> _getBody() {
    return BlocBuilder<PokemonDetailBloc, PokemonDetailState>(builder: (context, state) {
      if (state is PokemonDetailLoadingState) {
        return Center(
            child: Image.asset('assets/images/pokeball.png', width: 50,)
        );
      }

      if (state is PokemonDetailLoadedState) {
        return PokemonDetailItemWidget(
          pokemon: state.pokemon,
        );
      }

      return Container();
    });
  }
}