import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'models/admin_models.dart';

/// Gerenciar Mensagens: lista as mensagens dos cidadãos, permite filtrar por
/// status, responder e atualizar a situação. (mock em memória)
class MensagensAdminScreen extends StatefulWidget {
  const MensagensAdminScreen({super.key});

  @override
  State<MensagensAdminScreen> createState() => _MensagensAdminScreenState();
}

class _MensagensAdminScreenState extends State<MensagensAdminScreen> {
  String filtro = 'Todas';
  String busca = '';

  static const status = ['Pendente', 'Em andamento', 'Respondida', 'Arquivada'];

  Color _cor(String s) {
    switch (s) {
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

  List<Mensagem> get _filtradas {
    return AdminData.mensagens.where((m) {
      final okStatus = filtro == 'Todas' || m.status == filtro;
      final okBusca =
          busca.isEmpty ||
          m.cidadao.toLowerCase().contains(busca.toLowerCase()) ||
          m.protocolo.contains(busca) ||
          m.assunto.toLowerCase().contains(busca.toLowerCase());
      return okStatus && okBusca;
    }).toList();
  }

  void _abrir(Mensagem m) {
    final respostaCtrl = TextEditingController(text: m.resposta ?? '');
    String novoStatus = m.status;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setLocal) => AdminFormDialog(
          title: 'Mensagem #${m.protocolo}',
          icon: Icons.mark_email_read,
          submitLabel: 'Salvar resposta',
          onSubmit: () {
            setState(() {
              m.resposta = respostaCtrl.text.trim().isEmpty
                  ? null
                  : respostaCtrl.text.trim();
              m.status = novoStatus;
            });
            Navigator.pop(context);
            adminToast(context, 'Mensagem atualizada');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _info('Cidadão', m.cidadao),
              _info('Assunto', m.assunto),
              const SizedBox(height: 10),
              const FieldLabel('Mensagem do cidadão'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AdminColors.deep,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AdminColors.stroke),
                ),
                child: Text(
                  m.mensagem,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 14),
              const FieldLabel('Status'),
              DropdownButtonFormField<String>(
                value: novoStatus,
                dropdownColor: AdminColors.card,
                style: const TextStyle(color: Colors.white),
                decoration: adminField(),
                items: status
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setLocal(() => novoStatus = v!),
              ),
              const SizedBox(height: 14),
              const FieldLabel('Resposta'),
              TextField(
                controller: respostaCtrl,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: adminField(
                  hint: 'Escreva a resposta ao cidadão...',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lista = _filtradas;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            'Mensagens',
            subtitle: 'Solicitações e demandas dos cidadãos',
          ),
          const SizedBox(height: 16),
          AdminSearchField(
            hint: 'Buscar por nome, protocolo ou assunto...',
            onChanged: (v) => setState(() => busca = v),
          ),
          const SizedBox(height: 12),
          FilterChips(
            options: const ['Todas', ...status],
            selected: filtro,
            onSelected: (v) => setState(() => filtro = v),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: lista.isEmpty
                ? const EmptyState(
                    icon: Icons.inbox,
                    message: 'Nenhuma mensagem encontrada',
                  )
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (_, i) {
                      final m = lista[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AdminCard(
                          onTap: () => _abrir(m),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AdminColors.indigo.withOpacity(
                                  0.3,
                                ),
                                child: Text(
                                  m.cidadao.substring(0, 1),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            m.cidadao,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        StatusBadge(m.status, _cor(m.status)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${m.assunto} • #${m.protocolo}',
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      m.mensagem,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.white38,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
