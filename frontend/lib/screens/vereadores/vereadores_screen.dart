import 'package:flutter/material.dart';
import '../models/vereador.dart';
import 'vereador_detail.dart';

class VereadoresScreen extends StatefulWidget {
  const VereadoresScreen({super.key});

  @override
  State<VereadoresScreen> createState() => _VereadoresScreenState();
}

class _VereadoresScreenState extends State<VereadoresScreen> {
  String selectedFilter = "Todas";

  final List<String> filters = [
    "Todas",
    "Centro",
    "Norte",
    "Sul",
    "Leste",
    "Oeste",
  ];

  final List<Vereador> vereadores = [
    Vereador(
      nome: "Maria Silva Santos",
      partido: "Partido A",
      regiao: "Centro",
      nota: 4.8,
      avaliacoes: 128,
    ),
    Vereador(
      nome: "João Pedro Costa",
      partido: "Partido B",
      regiao: "Norte",
      nota: 4.5,
      avaliacoes: 128,
    ),
    Vereador(
      nome: "Ana Carolina Lima",
      partido: "Partido C",
      regiao: "Sul",
      nota: 4.9,
      avaliacoes: 128,
    ),
    Vereador(
      nome: "Carlos Alberto Souza",
      partido: "Partido D",
      regiao: "Leste",
      nota: 4.6,
      avaliacoes: 128,
    ),
    Vereador(
      nome: "Beatriz Oliveira",
      partido: "Partido E",
      regiao: "Oeste",
      nota: 4.7,
      avaliacoes: 128,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),

       
        automaticallyImplyLeading: false,

        title: const Text(
          "Vereadores",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [

          const SizedBox(height: 12),

        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar por nome...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

         
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final f = filters[index];
                final selected = f == selectedFilter;

                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = f),

                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.indigo
                          : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    alignment: Alignment.center,

                    child: Text(
                      f,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: vereadores.where((v) {
                return selectedFilter == "Todas" ||
                    v.regiao == selectedFilter;
              }).map(_card).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(Vereador v) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VereadorDetailScreen(vereador: v),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14),
        ),

        child: Row(
          children: [

            CircleAvatar(
              backgroundColor: Colors.indigo.withOpacity(0.3),
              child: Text(
                v.nome.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(v.nome,
                      style: const TextStyle(color: Colors.white)),

                  Text(v.partido,
                      style: const TextStyle(color: Colors.white70)),

                  Text(v.regiao,
                      style: const TextStyle(color: Colors.white54)),

                  const SizedBox(height: 6),

                  Text("⭐ ${v.nota} (${v.avaliacoes})",
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}