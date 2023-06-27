
import 'package:flutter/material.dart';

import 'package:mdp_pokedex_app/src/presentation/blocs/blocs.dart';
import 'package:mdp_pokedex_app/src/presentation/widgets/widgets.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/constants.dart';

class DialogSortPokemon extends StatelessWidget {
  const DialogSortPokemon({
    super.key,
    required this.pokemonBloc,
    required this.state,
  });

  final PokemonBloc pokemonBloc;
  final PokemonLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            right: 15,
            top: 120,
            child: Container(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric( vertical: 16, horizontal: 20),
                    child: const TextWidget(
                      text: 'Sort by:',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20, left: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<SortBy>(
                              value: SortBy.id,
                              groupValue: state.sortBy,
                              activeColor: AppColors.primary,
                              onChanged: (value) {
                                Navigator.pop(context);
                                pokemonBloc.add(SortPokemonsEvent(SortBy.id, state.query));
                              },
                            ),
                            const TextWidget(
                              text: 'Number',
                              color: AppColors.textTitleCard,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<SortBy>(
                              value: SortBy.name,
                              groupValue: state.sortBy,
                              activeColor: AppColors.primary,
                              onChanged: (value) {
                                Navigator.pop(context);
                                pokemonBloc.add(SortPokemonsEvent(SortBy.name, state.query));
                              },
                            ),
                            const TextWidget(
                              text: 'Name',
                              color: AppColors.textTitleCard,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
