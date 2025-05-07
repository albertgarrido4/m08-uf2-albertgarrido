import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_albert_garrido/viewmodel/character_viewmodel.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();
    final ch = vm.selectedCharacter!; // ya fue seleccionado al hacer tap

    return Scaffold(
      appBar: AppBar(title: Text(ch.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(ch.image),
            const SizedBox(height: 16),
            Text('Status: ${ch.status}'),
            Text('Especie: ${ch.species}'),
            Text('Género: ${ch.gender}'),
            Text('Origen: ${ch.origin}'),
            Text('Ubicación: ${ch.location}'),
          ],
        ),
      ),
    );
  }
}
