import 'package:flutter/material.dart';
import '../models/vereador.dart';

class VereadorDetailScreen extends StatelessWidget {
  final Vereador vereador;

  const VereadorDetailScreen({
    super.key,
    required this.vereador,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(vereador.nome),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

          
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.indigo.withOpacity(0.3),
              child: Text(
                vereador.nome.substring(0, 1),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              vereador.nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              vereador.partido,
              style: const TextStyle(color: Colors.white70),
            ),

            Text(
              vereador.regiao,
              style: const TextStyle(color: Colors.white54),
            ),

            const SizedBox(height: 20),

           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat("⭐ ${vereador.nota}", "Nota"),
                _stat("${vereador.avaliacoes}", "Avaliações"),
                _stat("342", "Demandas"),
              ],
            ),

            const SizedBox(height: 10),

            _bigStat("95%", "Taxa de Resposta"),

            const SizedBox(height: 20),

            
            _section(
              "Sobre",
              "Vereador atuante há vários anos, com foco em desenvolvimento urbano, saúde pública e educação. Atua diretamente em projetos sociais do município.",
            ),

            const SizedBox(height: 15),

            
            _section(
              "Contato",
              "vereador@camara.gov.br\n(44) 99999-9999",
            ),

            const SizedBox(height: 20),

            
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ações",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _action("Solicitação", Colors.blue),
                _action("Reclamação", Colors.orange),
                _action("Elogio", Colors.pink),
                _action("Agendar Reunião", Colors.green),
                _action("Comunicados", Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Text(label,
              style: const TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _bigStat(String value, String label) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$value • $label",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _section(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(content,
              style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }
}


class _action extends StatelessWidget {
  final String text;
  final Color color;

  const _action(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}