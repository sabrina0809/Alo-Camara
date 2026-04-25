import 'package:flutter/material.dart';

class AcaoScreen extends StatelessWidget {
  final String titulo;

  const AcaoScreen({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Center(
        child: Text(
          'Tela de $titulo',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}