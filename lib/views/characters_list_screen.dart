import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_albert_garrido/viewmodel/character_viewmodel.dart';
import 'package:proyecto_albert_garrido/views/characters_detail_screen.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty')),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre…',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: vm.fetchCharacters,
            ),
          ),
          // Lista + botón Cargar más
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
                        // Celda de “Cargar más”
                        if (!vm.hasMore) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: Text('— Fin de la lista —')),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: vm.isLoadingMore
                              ? const Center(
                                  child: CircularProgressIndicator())
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