import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_albert_garrido/viewmodel/character_viewmodel.dart';
import 'package:proyecto_albert_garrido/views/characters_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharacterViewModel>().fetchCharacters('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<CharacterViewModel>().fetchCharacters(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();
    final query = _searchController.text;

    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty')),
      body: Column(
        children: [
          // Campo de búsqueda en tiempo real
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre…',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _onSearchChanged(),
            ),
          ),

          // Mensaje de error de conexión
          if (vm.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      vm.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),

          // Mensaje cuando no hay resultados
          if (!vm.isLoading &&
              vm.errorMessage == null &&
              vm.characters.isEmpty &&
              query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "No se han encontrado resultados para «$query»",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),

          // Lista o spinner de carga
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: vm.characters.length + 1,
                    itemBuilder: (_, i) {
                      if (i < vm.characters.length) {
                        final ch = vm.characters[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(ch.image),
                          ),
                          title: Text(ch.name),
                          subtitle: Text('${ch.species} • ${ch.status}'),
                          onTap: () {
                            vm.selectCharacter(ch);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const CharacterDetailScreen(),
                              ),
                            );
                          },
                        );
                      } else {
                        // Pie de lista: cargar más o fin
                        if (!vm.hasMore) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child:
                                Center(child: Text('— Fin de la lista —')),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: vm.isLoadingMore
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: ElevatedButton(
                                    onPressed: vm.fetchMore,
                                    child: const Text('Cargar más'),
                                  ),
                                ),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
