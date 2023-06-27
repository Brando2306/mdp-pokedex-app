import 'package:flutter/material.dart';
import 'package:mdp_pokedex_app/src/domain/models/pokemon_model.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/colors.dart';

enum ColorEnum {
  grass,
  poison,
  fire,
  water,
  bug,
  flying,
  electric,
  ghost,
  normal,
  psychic,
  steel,
  rock
}

class PokemonHelper {

  static String formatPokemonId(PokemonResult result){
    final urlParts = result.url.split('/');
    final id = urlParts[urlParts.length - 2];
    return id;
  }

  static String formatIdNumber(String id) {
    return '#${id.padLeft(3, '0')}';
  }

  static String formatImage(String id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  static String formatCapitalizeName(String name) {
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  static Color formatColor(String name) {
    if(name == 'grass'){
      return AppColors.grass;
    }

    if(name == 'poison'){
      return AppColors.poison;
    }

    if(name == 'fire'){
      return AppColors.fire;
    }

    if(name == 'water'){
      return AppColors.water;
    }

    if(name == 'bug'){
      return AppColors.bug;
    }

    if(name == 'flying'){
      return AppColors.flying;
    }

    if(name == 'electric'){
      return AppColors.electric;
    }

    if(name == 'ghost'){
      return AppColors.ghost;
    }

    if(name == 'normal'){
      return AppColors.normal;
    }

    if(name == 'psychic'){
      return AppColors.psychic;
    }

    if(name == 'steel'){
      return AppColors.steel;
    }

    if(name == 'rock'){
      return AppColors.rock;
    }

    return AppColors.textLabelCard;
  }

  static String formatNameStat(String name) {
    if(name == 'attack'){
      return 'ATK';
    }
    if(name == 'defense'){
      return 'DEF';
    }
    if(name == 'special-attack'){
      return 'SATK';
    }
    if(name == 'special-defense'){
      return 'SDEF';
    }
     if(name == 'speed'){
      return 'SPD';
    }

    return 'HP';
  }
  
}