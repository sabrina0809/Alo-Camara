import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'models/admin_models.dart';

/// Gerenciar Horários: agenda de sessões, comissões e audiências. (mock)
class HorariosAdminScreen extends StatefulWidget {
  const HorariosAdminScreen({super.key});

  @override
  State<HorariosAdminScreen> createState() => _HorariosAdminScreenState();
}

class _HorariosAdminScreenState extends State<HorariosAdminScreen> {
  String filtro = 'Todos';

  static const tipos = ['Sessão', 'Comissão', 'Audiência'];

  Color _cor(String tipo) {
    switch (tipo) {
      case 'Sessão':
        return AdminColors.blue;
      case 'Comissão':
        return AdminColors.purple;
      default:
        return AdminColors.cyan;
    }
  }

  List<Horario> get _filtrados {
    final lista = AdminData.horarios
        .where((h) => filtro == 'Todos' || h.tipo == filtro)
        .toList();
    lista.sort((a, b) => a.dataHora.compareTo(b.dataHora));
    return lista;
  }

  void _editar({Horario? h}) {
    final isNovo = h == null;
    final titulo = TextEditingController(text: h?.titulo ?? '');
    final local = TextEditingController(text: h?.local ?? '');
    String tipo = h?.tipo ?? 'Sessão';
    DateTime dataHora =
        h?.dataHora ?? DateTime.now().add(const Duration(days: 1));
    bool ativo = h?.ativo ?? true;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setLocal) => AdminFormDialog(
          title: isNovo ? 'Novo Horário' : 'Editar Horário',
          icon: Icons.event,
          onSubmit: () {
            if (!formKey.currentState!.validate()) return;
            setState(() {
              if (isNovo) {
                AdminData.horarios.add(
                  Horario(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    titulo: titulo.text.trim(),
                    tipo: tipo,
                    local: local.text.trim(),
                    dataHora: dataHora,
                    ativo: ativo,
                  ),
                );
              } else {
                h.titulo = titulo.text.trim();
                h.tipo = tipo;
                h.local = local.text.trim();
                h.dataHora = dataHora;
                h.ativo = ativo;
              }
            });
            Navigator.pop(context);
            adminToast(
              context,
              isNovo ? 'Horário criado' : 'Horário atualizado',
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
                  decoration: adminField(hint: 'Ex.: Sessão Ordinária'),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Tipo'),
                DropdownButtonFormField<String>(
                  value: tipo,
                  dropdownColor: AdminColors.card,
                  style: const TextStyle(color: Colors.white),
                  decoration: adminField(),
                  items: tipos
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setLocal(() => tipo = v!),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Local'),
                TextFormField(
                  controller: local,
                  style: const TextStyle(color: Colors.white),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o local' : null,
                  decoration: adminField(
                    hint: 'Ex.: Plenário Principal',
                    icon: Icons.place,
                  ),
                ),
                const SizedBox(height: 12),
                const FieldLabel('Data e hora'),
                Row(
                  children: [
                    Expanded(
                      child: _pickerBox(
                        icon: Icons.calendar_today,
                        text: _dataBr(dataHora),
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: dataHora,
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365 * 2),
                            ),
                          );
                          if (d != null) {
                            setLocal(
                              () => dataHora = DateTime(
                                d.year,
                                d.month,
                                d.day,
                                dataHora.hour,
                                dataHora.minute,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _pickerBox(
                        icon: Icons.access_time,
                        text: _horaBr(dataHora),
                        onTap: () async {
                          final t = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(dataHora),
                          );
                          if (t != null) {
                            setLocal(
                              () => dataHora = DateTime(
                                dataHora.year,
                                dataHora.month,
                                dataHora.day,
                                t.hour,
                                t.minute,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: ativo,
                  activeColor: AdminColors.green,
                  title: const Text(
                    'Evento visível na agenda',
                    style: TextStyle(color: Colors.white),
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

  Widget _pickerBox({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AdminColors.deep,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.stroke),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 18),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(color: Colors.white)),
          ],
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
                  'Horários',
                  subtitle: 'Agenda de sessões e eventos',
                ),
              ),
              PrimaryActionButton(
                label: 'Novo horário',
                icon: Icons.add,
                onPressed: () => _editar(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilterChips(
            options: const ['Todos', ...tipos],
            selected: filtro,
            onSelected: (v) => setState(() => filtro = v),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: lista.isEmpty
                ? const EmptyState(
                    icon: Icons.event_busy,
                    message: 'Nenhum horário agendado',
                  )
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (_, i) {
                      final h = lista[i];
                      final cor = _cor(h.tipo);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AdminCard(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              // Faixa colorida lateral
                              Container(
                                width: 6,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: cor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          StatusBadge(h.tipo, cor),
                                          const SizedBox(width: 8),
                                          if (!h.ativo)
                                            const StatusBadge(
                                              'Oculto',
                                              Colors.white54,
                                            ),
                                          const Spacer(),
                                          MiniActionButton(
                                            icon: Icons.edit,
                                            label: 'Editar',
                                            color: AdminColors.blue,
                                            onTap: () => _editar(h: h),
                                          ),
                                          const SizedBox(width: 8),
                                          MiniActionButton(
                                            icon: Icons.delete,
                                            label: 'Excluir',
                                            color: AdminColors.red,
                                            onTap: () async {
                                              if (await confirmDelete(
                                                context,
                                                h.titulo,
                                              )) {
                                                setState(
                                                  () => AdminData.horarios
                                                      .remove(h),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        h.titulo,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.schedule,
                                            color: Colors.white38,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${_dataBr(h.dataHora)} às ${_horaBr(h.dataHora)}',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          const Icon(
                                            Icons.place,
                                            color: Colors.white38,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 6),
                                          Flexible(
                                            child: Text(
                                              h.local,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
  static String _horaBr(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}
