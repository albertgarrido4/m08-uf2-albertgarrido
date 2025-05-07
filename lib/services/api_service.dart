// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_albert_garrido/models/character.dart';

class PagedCharacters {
  final List<Character> list;
  final int pages;
  PagedCharacters({required this.list, required this.pages});
}

class ApiService {
  static const _baseUrl = 'https://rickandmortyapi.com/api';

  /// Devuelve lista de personajes y total de páginas
  Future<PagedCharacters> fetchCharactersPaged({
    String nameFilter = '',
    int page = 1,
  }) async {
    final uri = Uri.parse('$_baseUrl/character?name=$nameFilter&page=$page');
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Error cargando personajes');
    }
    final data = jsonDecode(resp.body);
    final results = (data['results'] as List<dynamic>)
        .map((e) => Character.fromJson(e))
        .toList();
    final pages = data['info']['pages'] as int;
    return PagedCharacters(list: results, pages: pages);
  }
}
