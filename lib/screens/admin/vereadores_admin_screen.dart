import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'models/admin_models.dart';

/// Gerenciar Vereadores: cadastrar, editar, ativar/inativar e excluir. (mock)
class VereadoresAdminScreen extends StatefulWidget {
  const VereadoresAdminScreen({super.key});

  @override
  State<VereadoresAdminScreen> createState() => _VereadoresAdminScreenState();
}

class _VereadoresAdminScreenState extends State<VereadoresAdminScreen> {
  String busca = '';

  static const regioes = ['Centro', 'Norte', 'Sul', 'Leste', 'Oeste'];

  List<VereadorAdmin> get _filtrados {
    return AdminData.vereadores.where((v) {
      return busca.isEmpty ||
          v.nome.toLowerCase().contains(busca.toLowerCase()) ||
          v.partido.toLowerCase().contains(busca.toLowerCase());
    }).toList();
  }

  void _editar({VereadorAdmin? v}) {
    final isNovo = v == null;
    final nome = TextEditingController(text: v?.nome ?? '');
    final partido = TextEditingController(text: v?.partido ?? '');
    final email = TextEditingController(text: v?.email ?? '');
    final telefone = TextEditingController(text: v?.telefone ?? '');
    final bio = TextEditingController(text: v?.biografia ?? '');
    String regiao = v?.regiao ?? 'Centro';
    bool ativo = v?.ativo ?? true;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setLocal) => AdminFormDialog(
          title: isNovo ? 'Novo Vereador' : 'Editar Vereador',
          icon: Icons.person_add,
          onSubmit: () {
            if (!formKey.currentState!.validate()) return;
            setState(() {
              if (isNovo) {
                AdminData.vereadores.add(
                  VereadorAdmin(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    nome: nome.text.trim(),
                    partido: partido.text.trim(),
                    regiao: regiao,
                    email: email.text.trim(),
                    telefone: telefone.text.trim(),
                    biografia: bio.text.trim(),
                    ativo: ativo,
                  ),
                );
              } else {
                v.nome = nome.text.trim();
                v.partido = partido.text.trim();
                v.regiao = regiao;
                v.email = email.text.trim();
                v.telefone = telefone.text.trim();
                v.biografia = bio.text.trim();
                v.ativo = ativo;
              }
            });
            Navigator.pop(context);
            adminToast(
              context,
              isNovo ? 'Vereador cadastrado' : 'Vereador atualizado',
            );
          },
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FieldLabel('Nome completo'),
                TextFormField(
                  controller: nome,
                  style: const TextStyle(color: Colors.white),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o nome' : null,
                  decoration: adminField(
                    hint: 'Nome do vereador',
                    icon: Icons.person,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel('Partido'),
                          TextFormField(
                            controller: partido,
                            style: const TextStyle(color: Colors.white),
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Informe o partido'
                                : null,
                            decoration: adminField(hint: 'Ex.: PSDB'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel('Região'),
                          DropdownButtonFormField<String>(
                            value: regiao,
                            dropdownColor: AdminColors.card,
                            style: const TextStyle(color: Colors.white),
                            decoration: adminField(),
                            items: regioes
                                .map(
                                  (r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) => setLocal(() => regiao = val!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const FieldLabel('E-mail'),
                TextFormField(
                  controller: email,
                  style: const TextStyle(color: Colors.white),
                  decoration: adminField(
                    hint: 'email@camara.gov.br',
                    icon: Icons.email,
                  ),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Telefone'),
                TextFormField(
                  controller: telefone,
                  style: const TextStyle(color: Colors.white),
                  decoration: adminField(
                    hint: '(44) 0000-0000',
                    icon: Icons.phone,
                  ),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Biografia'),
                TextFormField(
                  controller: bio,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: adminField(hint: 'Breve descrição e atuação...'),
                ),
                const SizedBox(height: 6),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: ativo,
                  activeColor: AdminColors.green,
                  title: const Text(
                    'Mandato ativo',
                    style: TextStyle(color: Colors.white),
                  ),
                  onChanged: (val) => setLocal(() => ativo = val),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lista = _filtrados;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: SectionTitle(
                  'Vereadores',
                  subtitle: 'Cadastro dos representantes',
                ),
              ),
              PrimaryActionButton(
                label: 'Novo vereador',
                icon: Icons.add,
                onPressed: () => _editar(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AdminSearchField(
            hint: 'Buscar por nome ou partido...',
            onChanged: (v) => setState(() => busca = v),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: lista.isEmpty
                ? const EmptyState(
                    icon: Icons.people,
                    message: 'Nenhum vereador cadastrado',
                  )
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (_, i) {
                      final v = lista[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AdminCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: AdminColors.indigo
                                        .withOpacity(0.3),
                                    child: Text(
                                      v.nome.substring(0, 1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                v.nome,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            StatusBadge(
                                              v.ativo ? 'Ativo' : 'Inativo',
                                              v.ativo
                                                  ? AdminColors.green
                                                  : Colors.white54,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${v.partido} • ${v.regiao}',
                                          style: const TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          v.email,
                                          style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  MiniActionButton(
                                    icon: v.ativo
                                        ? Icons.toggle_off
                                        : Icons.toggle_on,
                                    label: v.ativo ? 'Inativar' : 'Ativar',
                                    color: v.ativo
                                        ? AdminColors.orange
                                        : AdminColors.green,
                                    onTap: () =>
                                        setState(() => v.ativo = !v.ativo),
                                  ),
                                  const SizedBox(width: 8),
                                  MiniActionButton(
                                    icon: Icons.edit,
                                    label: 'Editar',
                                    color: AdminColors.blue,
                                    onTap: () => _editar(v: v),
                                  ),
                                  const SizedBox(width: 8),
                                  MiniActionButton(
                                    icon: Icons.delete,
                                    label: 'Excluir',
                                    color: AdminColors.red,
                                    onTap: () async {
                                      if (await confirmDelete(
                                        context,
                                        v.nome,
                                      )) {
                                        setState(
                                          () => AdminData.vereadores.remove(v),
                                        );
                                      }
                                    },
                                  ),
                                ],
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
