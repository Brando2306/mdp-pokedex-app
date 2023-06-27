import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mdp_pokedex_app/src/domain/models/models.dart';
import 'package:mdp_pokedex_app/src/presentation/pages/pages.dart';
import 'package:mdp_pokedex_app/src/presentation/widgets/widgets.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/constants.dart';

class PokemonItemWidget extends StatelessWidget {
  const PokemonItemWidget({super.key, required this.pokemon});

  final SimplePokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PokemonDetailPage(id: int.parse(pokemon.id))),
        );
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ]
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.backgroundPartHeight,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  width: double.infinity,
                  child: TextWidget(text: pokemon.idName, color: AppColors.textLabelCard, fontSize: 8, textAlign: TextAlign.end,)
                ),
                Expanded(
                  // child: Image.network(pokemon.picture, width: 72, height: 72)
                  child: FadeInImage(
                    width: 72,
                    height: 72,
                    placeholder: const AssetImage('assets/images/pokeball.png'),
                    image: NetworkImage(pokemon.picture),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                  child: TextWidget(text: pokemon.name, color: AppColors.textTitleCard, fontSize: 10)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}