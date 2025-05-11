// lib/viewmodels/character_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:proyecto_albert_garrido/models/character.dart';
import 'package:proyecto_albert_garrido/services/api_service.dart';

class CharacterViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  
  List<Character> _characters = [];
  List<Character> get characters => _characters;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  int _currentPage = 1;
  int _totalPages = 1;

  int get currentPage => _currentPage;
  int get totalPages   => _totalPages;
  bool get hasMore     => _currentPage < _totalPages;


  Character? _selected;
  Character? get selectedCharacter => _selected;

  get errorMessage => null;

  /// Carga la primera página (o tras cambiar filtro)
  Future<void> fetchCharacters([String filter = '']) async {
    _currentPage = 1;
    _totalPages = 1;
    _characters = [];
    _isLoading = true;
    notifyListeners();

    try {
      final pageData = await _api.fetchCharactersPaged(
        nameFilter: filter,
        page: _currentPage,
      );
      _characters = pageData.list;
      _totalPages = pageData.pages;
    } catch (_) {
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Carga la siguiente página si existe
  Future<void> fetchMore() async {
    if (_isLoadingMore || _currentPage >= _totalPages) return;
    _isLoadingMore = true;
    notifyListeners();

    try {
      final nextPage = _currentPage + 1;
      final pageData = await _api.fetchCharactersPaged(
        page: nextPage,
      );
      _characters.addAll(pageData.list);
      _currentPage = nextPage;
    } catch (_) {
      // puedes mostrar error si quieres
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  void selectCharacter(Character c) {
    _selected = c;
    notifyListeners();
  }
}
