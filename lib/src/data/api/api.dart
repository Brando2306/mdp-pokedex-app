import 'package:dio/dio.dart';
import 'package:mdp_pokedex_app/src/domain/models/models.dart';

class Api {
  static final Dio _dio = Dio();
  static String path = "https://pokeapi.co/api";

  Future<PokemonPaginatedResponse> getPokemons() async {
    String url = "/v2/pokemon?limit=50";
    try {
      final response = await _dio.get('$path$url');
      final list = PokemonPaginatedResponse.fromJson(response.data);
      return list;
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<PokemonFull> getPokemonDetail(int id) async {
    String url = "/v2/pokemon/$id";
    try {
      final response = await _dio.get('$path$url');
      final pokemon = PokemonFull.fromJson(response.data);
      return pokemon;
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
