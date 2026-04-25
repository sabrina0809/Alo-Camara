import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ComunicadosScreen extends StatelessWidget {
  const ComunicadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Comunicados'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Fique informado sobre tudo',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          _filterRow(),

          const SizedBox(height: 20),

          _card(
            tag: 'URGENTE',
            color: Colors.red,
            title: 'Interrupção no fornecimento de água',
            description:
                'Manutenção programada na Rua Central afetará o abastecimento entre 8h e 14h neste sábado.',
            category: 'Infraestrutura',
            date: '27 de fev.',
          ),

          _card(
            tag: 'EVENTO',
            color: Colors.green,
            title: 'Audiência Pública sobre Transporte',
            description:
                'Participe da discussão sobre melhorias no transporte público. Dia 01/03 às 09h no Auditório.',
            category: 'Evento',
            date: '26 de fev.',
          ),

          _card(
            tag: 'SAÚDE',
            color: Colors.blue,
            title: 'Nova campanha de vacinação',
            description:
                'Postos de saúde estarão abertos no sábado para vacinação contra gripe. Traga documento e carteira de vacinação.',
            category: 'Saúde',
            date: '25 de fev.',
          ),

          _card(
            tag: 'TRÂNSITO',
            color: Colors.orange,
            title: 'Desvio na Av. Principal',
            description:
                'Obras de recapeamento causarão desvio no trânsito até sexta-feira. Use vias alternativas.',
            category: 'Trânsito',
            date: '24 de fev.',
          ),

          _card(
            tag: 'EDUCAÇÃO',
            color: Colors.purple,
            title: 'Inscrições abertas para curso gratuito',
            description:
                'Curso de informática básica para a comunidade. Inscrições até 05/03 na Secretaria de Educação.',
            category: 'Educação',
            date: '23 de fev.',
          ),

          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Carregar mais comunicados',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _filterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: const [

          _chip('Todos'),
          SizedBox(width: 8),
          _chip('Urgentes'),
          SizedBox(width: 8),
          _chip('Eventos'),
          SizedBox(width: 8),
          _chip('Trânsito'),
        ],
      ),
    );
  }
}


class _chip extends StatelessWidget {
  final String label;

  const _chip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}


Widget _card({
  required String tag,
  required Color color,
  required String title,
  required String description,
  required String category,
  required String date,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),

    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(14),

      border: Border.all(color: color.withOpacity(0.4)),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // TAG
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              category,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
              ),
            ),

            Text(
              date,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}