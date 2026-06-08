import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SolicitacoesScreen extends StatelessWidget {
  const SolicitacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Minhas Solicitações'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Acompanhe o andamento das suas demandas',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 20),

   
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.spaceBetween,
            children: const [
              _statCard('Total', '4', Colors.blue),
              _statCard('Análise', '1', Colors.orange),
              _statCard('Respondido', '1', Colors.blueAccent),
              _statCard('Concluído', '1', Colors.green),
            ],
          ),

          const SizedBox(height: 20),

          _card(
            protocolo: 'AL20240001',
            tipo: 'Solicitação',
            titulo: 'Reparo de calçada na Rua das Flores',
            categoria: 'Infraestrutura',
            usuario: 'Maria Silva Santos',
            data: '24 de fev. de 2026',
            status: 'Em Análise',
            statusColor: Colors.orange,
          ),

          _card(
            protocolo: 'AL20240002',
            tipo: 'Reclamação',
            titulo: 'Iluminação pública defeituosa',
            categoria: 'Infraestrutura',
            usuario: 'João Pedro Costa',
            data: '22 de fev. de 2026',
            status: 'Respondido',
            statusColor: Colors.blue,
          ),

          _card(
            protocolo: 'AL20240003',
            tipo: 'Elogio',
            titulo: 'Excelente atendimento no posto de saúde',
            categoria: 'Saúde',
            usuario: 'Ana Carolina Lima',
            data: '19 de fev. de 2026',
            status: 'Finalizado',
            statusColor: Colors.green,
          ),

          _card(
            protocolo: 'AL20240004',
            tipo: 'Solicitação',
            titulo: 'Instalação de academia ao ar livre',
            categoria: 'Lazer',
            usuario: 'Carlos Alberto Souza',
            data: '17 de fev. de 2026',
            status: 'Recebido',
            statusColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}


class _statCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _statCard(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),

      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}


Widget _card({
  required String protocolo,
  required String tipo,
  required String titulo,
  required String categoria,
  required String usuario,
  required String data,
  required String status,
  required Color statusColor,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: const Color(0xFF0B172A),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.blue.withOpacity(0.4),
      ),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

     
        Row(
          children: [
            Text(
              protocolo,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            const Text("•", style: TextStyle(color: Colors.white38)),
            const SizedBox(width: 6),
            Text(
              tipo,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                categoria,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              usuario,
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          data,
          style: const TextStyle(color: Colors.white38),
        ),

        const SizedBox(height: 14),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statusItem("Recebido", true),
            _statusItem("Em Análise", status != "Recebido"),
            _statusItem("Respondido", status == "Respondido" || status == "Finalizado"),
            _statusItem("Finalizado", status == "Finalizado"),
          ],
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.visibility,
                  size: 16, color: Colors.blueAccent),
              label: const Text(
                "Ver detalhes",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _statusItem(String text, bool active) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),

    child: Row(
      children: [

        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: active ? Colors.green : Colors.transparent,
            border: Border.all(
              color: active ? Colors.green : Colors.white38,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 8),

        Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.white38,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}