import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mdp_pokedex_app/src/presentation/blocs/blocs.dart';
import 'package:mdp_pokedex_app/src/presentation/pages/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PokemonBloc()),
        BlocProvider(create: (_) => PokemonDetailBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex Bloc App',
        home: PokedexPage()
      ),
    );
  }
}