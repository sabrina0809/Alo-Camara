import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'models/admin_models.dart';

/// Visão geral do painel: estatísticas + atividade recente + atalhos.
class AdminDashboard extends StatelessWidget {
  /// Permite navegar para um módulo pelo índice da sidebar.
  final ValueChanged<int> onGoTo;
  const AdminDashboard({super.key, required this.onGoTo});

  @override
  Widget build(BuildContext context) {
    final pendentes = AdminData.mensagens
        .where((m) => m.status == 'Pendente')
        .length;
    final publicadas = AdminData.noticias.where((n) => n.publicado).length;
    final vereadoresAtivos = AdminData.vereadores.where((v) => v.ativo).length;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SectionTitle(
          'Visão Geral',
          subtitle: 'Resumo do painel administrativo',
        ),
        const SizedBox(height: 20),

        // Cartões de estatísticas
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth > 900 ? 4 : (c.maxWidth > 560 ? 2 : 1);
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 2.4,
              children: [
                _StatCard(
                  icon: Icons.mark_email_unread,
                  color: AdminColors.orange,
                  value: '$pendentes',
                  label: 'Mensagens pendentes',
                  onTap: () => onGoTo(1),
                ),
                _StatCard(
                  icon: Icons.article,
                  color: AdminColors.blue,
                  value: '$publicadas/${AdminData.noticias.length}',
                  label: 'Notícias publicadas',
                  onTap: () => onGoTo(2),
                ),
                _StatCard(
                  icon: Icons.people,
                  color: AdminColors.green,
                  value: '$vereadoresAtivos',
                  label: 'Vereadores ativos',
                  onTap: () => onGoTo(3),
                ),
                _StatCard(
                  icon: Icons.event,
                  color: AdminColors.purple,
                  value: '${AdminData.horarios.length}',
                  label: 'Eventos agendados',
                  onTap: () => onGoTo(4),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 24),

        // Atividade recente (últimas mensagens)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Mensagens recentes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => onGoTo(1),
              child: const Text(
                'Ver todas',
                style: TextStyle(color: AdminColors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...AdminData.mensagens
            .take(3)
            .map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AdminCard(
                  onTap: () => onGoTo(1),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AdminColors.indigo.withOpacity(0.3),
                        child: Text(
                          m.cidadao.substring(0, 1),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.cidadao,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${m.assunto} • #${m.protocolo}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StatusBadge(m.status, _statusColor(m.status)),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }

  static Color _statusColor(String status) {
    switch (status) {
      case 'Pendente':
        return AdminColors.orange;
      case 'Em andamento':
        return AdminColors.blue;
      case 'Respondida':
        return AdminColors.green;
      default:
        return Colors.white54;
    }
  }
}

class _StatCard extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;
  final VoidCallback onTap;
  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
    required this.onTap,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AdminColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AdminColors.stroke),
            boxShadow: hover
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.4),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
