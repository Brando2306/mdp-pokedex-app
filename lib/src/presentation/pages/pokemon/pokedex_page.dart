import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mdp_pokedex_app/src/presentation/blocs/blocs.dart';
import 'package:mdp_pokedex_app/src/presentation/widgets/widgets.dart';
import 'package:mdp_pokedex_app/src/presentation/common/styles/styles.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/colors.dart';
import 'package:mdp_pokedex_app/src/presentation/pages/pokemon/widgets/widgets.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final TextEditingController _searchController = TextEditingController();

  void initFunctions() {
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context, listen: false);
    pokemonBloc.add(GetPokemonsEvent());
  }

  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  Widget _getBody(context) {
    return ContainerWidget(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              _getHeader(context),
              _getContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeader(context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      child: Column(
        children: [
          _getTitleHeader(),
          _getSearchHeader(context),
        ],
      )
    );
  }

  Widget _getTitleHeader() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/pokeball.svg',
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 16),
        const TextWidget(
          text: 'Pokédex',
          fontSize: 24,
        ),
      ],
    );
  }

  Widget _getSearchHeader(context) {
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if(state is PokemonLoadedState){
          return Container(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    style: const TextStyle(color: AppColors.textInput, fontSize: 10),
                    decoration: CustomInputs.searchHomeInputDecoration(
                      hintText: 'Search',
                      prefixIcon: _getPrefixIcon(context),
                      suffixIcon: state.query.isNotEmpty  ? _getSuffixIcon(pokemonBloc, state) : null,
                      isDense: true,
                    ),
                    controller: _searchController,
                    onChanged: (value) {
                      pokemonBloc.add(SortPokemonsEvent(state.sortBy, value));
                    },
                  ),
                ),
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogSortPokemon(pokemonBloc: pokemonBloc, state: state);
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      state.sortBy == SortBy.id ? Icons.numbers: Icons.text_format_rounded,
                      color: AppColors.primary,
                      size: 16
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _getPrefixIcon(context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 8),
      child: const Icon(Icons.search, color: AppColors.primary, size: 16),
    );
  }

  Widget _getSuffixIcon(pokemonBloc, state) {
    return CupertinoButton(
      minSize: 0,
      padding: const EdgeInsets.only(left: 8, right: 12),
      child: const Icon(Icons.close, color: AppColors.primary, size: 16),
      onPressed: () {
        pokemonBloc.add(SortPokemonsEvent(state.sortBy, ''));
        _searchController.clear();
      }
    );
  }

  Widget _getContainer() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, -2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadingState) {
              return const Center(
                child: TextWidget(text: 'Cargando ...', color: AppColors.textTitleCard)
              );
            }

            if (state is PokemonErrorState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: state.errorMessage, color: AppColors.textTitleCard),
                  CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    onPressed: initFunctions,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const TextWidget(text: 'Volver a cargar', color: AppColors.primary),
                    ),
                  ),
                ],
              );
            }

            if (state is PokemonLoadedState) {
              if(state.sortedPokemons.isEmpty){
                return const Center(
                  child: TextWidget(
                    text: 'No se encontraron pokemones',
                    color: AppColors.textLabelCard
                  ),
                );
              }

              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: state.sortedPokemons.length,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (context, index) {
                  final pokemon = state.sortedPokemons[index];
                  return PokemonItemWidget(pokemon: pokemon);
                },
              );
            }

            return Container();
          }
        ),
      ),
    );
  }
}