import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'models/admin_models.dart';

/// Gerenciar Assuntos Gerais: categorias usadas para classificar mensagens
/// e solicitações. Permite escolher ícone e cor. (mock)
class AssuntosAdminScreen extends StatefulWidget {
  const AssuntosAdminScreen({super.key});

  @override
  State<AssuntosAdminScreen> createState() => _AssuntosAdminScreenState();
}

class _AssuntosAdminScreenState extends State<AssuntosAdminScreen> {
  String busca = '';

  // Opções de ícone e cor para os assuntos.
  static const _icones = <IconData>[
    Icons.lightbulb,
    Icons.local_hospital,
    Icons.add_road,
    Icons.school,
    Icons.park,
    Icons.security,
    Icons.water_drop,
    Icons.delete,
    Icons.directions_bus,
    Icons.home_work,
  ];

  static const _cores = <Color>[
    AdminColors.blue,
    AdminColors.green,
    AdminColors.orange,
    AdminColors.red,
    AdminColors.purple,
    AdminColors.cyan,
    AdminColors.indigo,
  ];

  List<Assunto> get _filtrados {
    return AdminData.assuntos.where((a) {
      return busca.isEmpty ||
          a.nome.toLowerCase().contains(busca.toLowerCase());
    }).toList();
  }

  void _editar({Assunto? a}) {
    final isNovo = a == null;
    final nome = TextEditingController(text: a?.nome ?? '');
    final descricao = TextEditingController(text: a?.descricao ?? '');
    IconData icone = a?.icone ?? _icones.first;
    Color cor = a?.cor ?? _cores.first;
    bool ativo = a?.ativo ?? true;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setLocal) => AdminFormDialog(
          title: isNovo ? 'Novo Assunto' : 'Editar Assunto',
          icon: Icons.category,
          onSubmit: () {
            if (!formKey.currentState!.validate()) return;
            setState(() {
              if (isNovo) {
                AdminData.assuntos.add(
                  Assunto(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    nome: nome.text.trim(),
                    descricao: descricao.text.trim(),
                    icone: icone,
                    cor: cor,
                    ativo: ativo,
                  ),
                );
              } else {
                a.nome = nome.text.trim();
                a.descricao = descricao.text.trim();
                a.icone = icone;
                a.cor = cor;
                a.ativo = ativo;
              }
            });
            Navigator.pop(context);
            adminToast(
              context,
              isNovo ? 'Assunto criado' : 'Assunto atualizado',
            );
          },
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pré-visualização
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icone, color: cor, size: 32),
                  ),
                ),
                const SizedBox(height: 16),
                const FieldLabel('Nome do assunto'),
                TextFormField(
                  controller: nome,
                  style: const TextStyle(color: Colors.white),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o nome' : null,
                  decoration: adminField(hint: 'Ex.: Iluminação Pública'),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Descrição'),
                TextFormField(
                  controller: descricao,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  decoration: adminField(hint: 'O que este assunto cobre...'),
                ),
                const SizedBox(height: 14),
                const FieldLabel('Ícone'),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _icones.map((ic) {
                    final sel = ic == icone;
                    return GestureDetector(
                      onTap: () => setLocal(() => icone = ic),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: sel ? cor.withOpacity(0.2) : AdminColors.deep,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: sel ? cor : AdminColors.stroke,
                            width: sel ? 2 : 1,
                          ),
                        ),
                        child: Icon(ic, color: sel ? cor : Colors.white54),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                const FieldLabel('Cor'),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _cores.map((c) {
                    final sel = c == cor;
                    return GestureDetector(
                      onTap: () => setLocal(() => cor = c),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: sel ? Colors.white : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: sel
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 6),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: ativo,
                  activeColor: AdminColors.green,
                  title: const Text(
                    'Assunto ativo',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Disponível para o cidadão selecionar',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  onChanged: (v) => setLocal(() => ativo = v),
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
                  'Assuntos Gerais',
                  subtitle: 'Categorias para classificar as demandas',
                ),
              ),
              PrimaryActionButton(
                label: 'Novo assunto',
                icon: Icons.add,
                onPressed: () => _editar(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AdminSearchField(
            hint: 'Buscar assunto...',
            onChanged: (v) => setState(() => busca = v),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: lista.isEmpty
                ? const EmptyState(
                    icon: Icons.category,
                    message: 'Nenhum assunto cadastrado',
                  )
                : LayoutBuilder(
                    builder: (context, c) {
                      final cols = c.maxWidth > 1100
                          ? 3
                          : (c.maxWidth > 680 ? 2 : 1);
                      return GridView.count(
                        crossAxisCount: cols,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.6,
                        children: lista.map((a) {
                          return AdminCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: a.cor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(a.icone, color: a.cor),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            a.nome,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            a.ativo ? 'Ativo' : 'Inativo',
                                            style: TextStyle(
                                              color: a.ativo
                                                  ? AdminColors.green
                                                  : Colors.white38,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    a.descricao,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    MiniActionButton(
                                      icon: Icons.edit,
                                      label: 'Editar',
                                      color: AdminColors.blue,
                                      onTap: () => _editar(a: a),
                                    ),
                                    const SizedBox(width: 8),
                                    MiniActionButton(
                                      icon: Icons.delete,
                                      label: 'Excluir',
                                      color: AdminColors.red,
                                      onTap: () async {
                                        if (await confirmDelete(
                                          context,
                                          a.nome,
                                        )) {
                                          setState(
                                            () => AdminData.assuntos.remove(a),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
