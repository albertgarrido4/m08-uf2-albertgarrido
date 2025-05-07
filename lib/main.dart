import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_albert_garrido/viewmodel/character_viewmodel.dart';
import 'package:proyecto_albert_garrido/views/characters_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterViewModel()..fetchCharacters(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty Catalog',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CharacterListScreen(),
    );
  }
}
