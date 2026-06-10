import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'models/admin_models.dart';

/// Gerenciar Notícias: criar, editar, excluir e publicar/despublicar. (mock)
class NoticiasAdminScreen extends StatefulWidget {
  const NoticiasAdminScreen({super.key});

  @override
  State<NoticiasAdminScreen> createState() => _NoticiasAdminScreenState();
}

class _NoticiasAdminScreenState extends State<NoticiasAdminScreen> {
  String filtro = 'Todas';
  String busca = '';

  static const categorias = ['Geral', 'Sessão', 'Audiência', 'Comunicado'];

  List<Noticia> get _filtradas {
    return AdminData.noticias.where((n) {
      final okCat = filtro == 'Todas' || n.categoria == filtro;
      final okBusca =
          busca.isEmpty || n.titulo.toLowerCase().contains(busca.toLowerCase());
      return okCat && okBusca;
    }).toList();
  }

  void _editar({Noticia? noticia}) {
    final isNovo = noticia == null;
    final titulo = TextEditingController(text: noticia?.titulo ?? '');
    final resumo = TextEditingController(text: noticia?.resumo ?? '');
    final conteudo = TextEditingController(text: noticia?.conteudo ?? '');
    String categoria = noticia?.categoria ?? 'Geral';
    bool publicado = noticia?.publicado ?? false;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setLocal) => AdminFormDialog(
          title: isNovo ? 'Nova Notícia' : 'Editar Notícia',
          icon: Icons.article,
          onSubmit: () {
            if (!formKey.currentState!.validate()) return;
            setState(() {
              if (isNovo) {
                AdminData.noticias.insert(
                  0,
                  Noticia(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    titulo: titulo.text.trim(),
                    resumo: resumo.text.trim(),
                    conteudo: conteudo.text.trim(),
                    categoria: categoria,
                    publicado: publicado,
                    data: DateTime.now(),
                  ),
                );
              } else {
                noticia.titulo = titulo.text.trim();
                noticia.resumo = resumo.text.trim();
                noticia.conteudo = conteudo.text.trim();
                noticia.categoria = categoria;
                noticia.publicado = publicado;
              }
            });
            Navigator.pop(context);
            adminToast(
              context,
              isNovo ? 'Notícia criada' : 'Notícia atualizada',
            );
          },
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FieldLabel('Título'),
                TextFormField(
                  controller: titulo,
                  style: const TextStyle(color: Colors.white),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o título' : null,
                  decoration: adminField(hint: 'Título da notícia'),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Resumo'),
                TextFormField(
                  controller: resumo,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o resumo' : null,
                  decoration: adminField(
                    hint: 'Breve resumo exibido na listagem',
                  ),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Conteúdo'),
                TextFormField(
                  controller: conteudo,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o conteúdo' : null,
                  decoration: adminField(hint: 'Texto completo da notícia...'),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Categoria'),
                DropdownButtonFormField<String>(
                  value: categoria,
                  dropdownColor: AdminColors.card,
                  style: const TextStyle(color: Colors.white),
                  decoration: adminField(),
                  items: categorias
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setLocal(() => categoria = v!),
                ),
                const SizedBox(height: 6),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: publicado,
                  activeColor: AdminColors.green,
                  title: const Text(
                    'Publicar imediatamente',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Visível no app do cidadão',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  onChanged: (v) => setLocal(() => publicado = v),
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
    final lista = _filtradas;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: SectionTitle(
                  'Notícias',
                  subtitle: 'Comunicados e publicações',
                ),
              ),
              PrimaryActionButton(
                label: 'Nova notícia',
                icon: Icons.add,
                onPressed: () => _editar(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AdminSearchField(
            hint: 'Buscar por título...',
            onChanged: (v) => setState(() => busca = v),
          ),
          const SizedBox(height: 12),
          FilterChips(
            options: const ['Todas', ...categorias],
            selected: filtro,
            onSelected: (v) => setState(() => filtro = v),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: lista.isEmpty
                ? const EmptyState(
                    icon: Icons.article,
                    message: 'Nenhuma notícia cadastrada',
                  )
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (_, i) {
                      final n = lista[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AdminCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  StatusBadge(n.categoria, AdminColors.indigo),
                                  const SizedBox(width: 8),
                                  StatusBadge(
                                    n.publicado ? 'Publicado' : 'Rascunho',
                                    n.publicado
                                        ? AdminColors.green
                                        : AdminColors.orange,
                                  ),
                                  const Spacer(),
                                  Text(
                                    _dataBr(n.data),
                                    style: const TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                n.titulo,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                n.resumo,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  MiniActionButton(
                                    icon: n.publicado
                                        ? Icons.visibility_off
                                        : Icons.publish,
                                    label: n.publicado
                                        ? 'Despublicar'
                                        : 'Publicar',
                                    color: n.publicado
                                        ? AdminColors.orange
                                        : AdminColors.green,
                                    onTap: () => setState(
                                      () => n.publicado = !n.publicado,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  MiniActionButton(
                                    icon: Icons.edit,
                                    label: 'Editar',
                                    color: AdminColors.blue,
                                    onTap: () => _editar(noticia: n),
                                  ),
                                  const SizedBox(width: 8),
                                  MiniActionButton(
                                    icon: Icons.delete,
                                    label: 'Excluir',
                                    color: AdminColors.red,
                                    onTap: () async {
                                      if (await confirmDelete(
                                        context,
                                        n.titulo,
                                      )) {
                                        setState(
                                          () => AdminData.noticias.remove(n),
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

  static String _dataBr(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
