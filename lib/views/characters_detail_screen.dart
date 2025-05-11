import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_albert_garrido/viewmodel/character_viewmodel.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();
    final ch = vm.selectedCharacter!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(ch.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Imagen con sombra y borde circular
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(ch.image),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 16),

            // Card con detalles
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre grande
                    Text(
                      ch.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),

                    // Chips con estado, especie y género
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildChip(Icons.favorite, ch.status),
                        _buildChip(Icons.pets, ch.species),
                        _buildChip(Icons.wc, ch.gender),
                      ],
                    ),
                    const Divider(height: 32),

                    // Origen y ubicación
                    _buildInfoRow(Icons.public, 'Origen', ch.origin),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.place, 'Ubicación', ch.location),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.white70),
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blueAccent,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[900]),
          ),
        ),
      ],
    );
  }
}
