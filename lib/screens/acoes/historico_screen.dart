import 'package:flutter/material.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("História da Câmara"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [

          _timelineItem(
            ano: "2024",
            titulo: "João Silva",
            descricao: "Eleito com foco em infraestrutura urbana.",
          ),

          _timelineItem(
            ano: "2020",
            titulo: "Maria Souza",
            descricao: "Atuação voltada à saúde e educação.",
          ),

          _timelineItem(
            ano: "2016",
            titulo: "Carlos Lima",
            descricao: "Projetos de mobilidade urbana e segurança.",
          ),

          _timelineItem(
            ano: "2012",
            titulo: "Ana Ribeiro",
            descricao: "Fortalecimento da cultura local.",
          ),
        ],
      ),
    );
  }
}


class _timelineItem extends StatelessWidget {
  final String ano;
  final String titulo;
  final String descricao;

  const _timelineItem({
    required this.ano,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 80,
              color: Colors.white24,
            ),
          ],
        ),

        const SizedBox(width: 12),

    
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  ano,
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  descricao,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}