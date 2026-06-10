import 'package:flutter/material.dart';

/// Paleta do painel administrativo.
/// Mantém o mesmo tom escuro do app do cidadão (0xFF0F172A / 0xFF1E293B)
/// e reaproveita o gradiente azul -> roxo da marca.
class AdminColors {
  static const bg = Color(0xFF0F172A);
  static const deep = Color(0xFF020617);
  static const card = Color(0xFF1E293B);
  static const field = Color(0xFF334155);
  static const stroke = Color(0x1FFFFFFF); // white12

  static const blue = Color(0xFF3B82F6);
  static const purple = Color(0xFF8B5CF6);
  static const indigo = Color(0xFF4F46E5);

  static const green = Color(0xFF22C55E);
  static const orange = Color(0xFFF59E0B);
  static const red = Color(0xFFEF4444);
  static const cyan = Color(0xFF06B6D4);

  static const gradient = LinearGradient(colors: [blue, purple]);
}

/// Decoração padrão para campos de formulário do admin.
InputDecoration adminField({String? hint, IconData? icon, Widget? suffix}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.white38),
    prefixIcon: icon == null ? null : Icon(icon, color: Colors.white54),
    suffixIcon: suffix,
    filled: true,
    fillColor: AdminColors.deep,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AdminColors.stroke),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AdminColors.blue),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

/// Card base do painel (mesma cor/raio dos cards do app).
class AdminCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const AdminCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AdminColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.stroke),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: content,
    );
  }
}

/// Título de seção.
class SectionTitle extends StatelessWidget {
  final String text;
  final String? subtitle;
  const SectionTitle(this.text, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle!, style: const TextStyle(color: Colors.white54)),
        ],
      ],
    );
  }
}

/// Etiqueta de status colorida (ex.: "Publicado", "Pendente").
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const StatusBadge(this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Campo de busca padrão das listagens.
class AdminSearchField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  const AdminSearchField({
    super.key,
    this.hint = 'Buscar...',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: adminField(hint: hint, icon: Icons.search),
    );
  }
}

/// Botão de ação primário com hover (mesmo "feel" do app).
class PrimaryActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<PrimaryActionButton> createState() => _PrimaryActionButtonState();
}

class _PrimaryActionButtonState extends State<PrimaryActionButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          decoration: BoxDecoration(
            gradient: AdminColors.gradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: hover
                ? [
                    BoxShadow(
                      color: AdminColors.blue.withOpacity(0.5),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Estado vazio para listas sem itens.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  const EmptyState({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white24, size: 48),
            const SizedBox(height: 12),
            Text(message, style: const TextStyle(color: Colors.white38)),
          ],
        ),
      ),
    );
  }
}

/// Chips de filtro horizontais (mesmo padrão das telas do cidadão).
class FilterChips extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  const FilterChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (_, i) {
          final f = options[i];
          final sel = f == selected;
          return GestureDetector(
            onTap: () => onSelected(f),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: sel ? AdminColors.indigo : AdminColors.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AdminColors.stroke),
              ),
              child: Text(f, style: const TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}

/// Diálogo de confirmação de exclusão. Retorna true se confirmado.
Future<bool> confirmDelete(BuildContext context, String item) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: AdminColors.card,
      title: const Text('Excluir', style: TextStyle(color: Colors.white)),
      content: Text(
        'Tem certeza que deseja excluir "$item"? Esta ação não pode ser desfeita.',
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Excluir',
            style: TextStyle(color: AdminColors.red),
          ),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Mostra um snackbar simples de feedback.
void adminToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AdminColors.indigo,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// Casca de um modal de formulário (largura fixa, fundo card).
/// Use dentro de showDialog para criar/editar registros.
class AdminFormDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final String submitLabel;
  final VoidCallback onSubmit;
  final double width;

  const AdminFormDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    required this.onSubmit,
    this.submitLabel = 'Salvar',
    this.width = 560,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AdminColors.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: width,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AdminColors.stroke),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cabeçalho com gradiente
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                gradient: AdminColors.gradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Corpo
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ),
            // Rodapé
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(width: 8),
                  PrimaryActionButton(
                    label: submitLabel,
                    icon: Icons.check,
                    onPressed: onSubmit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Botão pequeno de ação para usar dentro dos cards de listagem
/// (Editar, Excluir, Ativar, etc.).
class MiniActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const MiniActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 15),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

/// Rótulo + espaçamento para campos dentro dos formulários.
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
    );
  }
}
