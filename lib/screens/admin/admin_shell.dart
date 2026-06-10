import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'admin_dashboard.dart';
import 'mensagens_admin_screen.dart';
import 'noticias_admin_screen.dart';
import 'vereadores_admin_screen.dart';
import 'horarios_admin_screen.dart';
import 'assuntos_admin_screen.dart';

/// Item de navegação do painel.
class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}

const _navItems = <_NavItem>[
  _NavItem('Visão Geral', Icons.dashboard),
  _NavItem('Mensagens', Icons.mark_email_unread),
  _NavItem('Notícias', Icons.article),
  _NavItem('Vereadores', Icons.people),
  _NavItem('Horários', Icons.event),
  _NavItem('Assuntos Gerais', Icons.category),
];

/// Casca do painel administrativo (layout web com sidebar).
/// Responsivo: em telas < 900px a sidebar vira um Drawer.
class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int index = 0;

  Widget _body() {
    switch (index) {
      case 0:
        return AdminDashboard(onGoTo: (i) => setState(() => index = i));
      case 1:
        return const MensagensAdminScreen();
      case 2:
        return const NoticiasAdminScreen();
      case 3:
        return const VereadoresAdminScreen();
      case 4:
        return const HorariosAdminScreen();
      case 5:
        return const AssuntosAdminScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: AdminColors.bg,
      drawer: wide
          ? null
          : Drawer(
              child: _Sidebar(
                index: index,
                onSelect: (i) {
                  setState(() => index = i);
                  Navigator.pop(context); // fecha o drawer
                },
              ),
            ),
      appBar: wide
          ? null
          : AppBar(
              backgroundColor: AdminColors.card,
              title: Text(
                _navItems[index].label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
      body: Row(
        children: [
          if (wide)
            _Sidebar(index: index, onSelect: (i) => setState(() => index = i)),
          Expanded(child: SafeArea(child: _body())),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onSelect;
  const _Sidebar({required this.index, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: AdminColors.deep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Marca
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF22D3EE)],
                    ),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alô Câmara',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Painel Admin',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: AdminColors.stroke, height: 1),
          const SizedBox(height: 10),
          // Itens
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _navItems.length,
              itemBuilder: (_, i) => _NavTile(
                item: _navItems[i],
                selected: i == index,
                onTap: () => onSelect(i),
              ),
            ),
          ),
          const Divider(color: AdminColors.stroke, height: 1),
          // Rodapé: usuário + sair
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: AdminColors.indigo,
                      child: Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Administrador',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          Text(
                            'admin@camara.gov.br',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AdminColors.red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AdminColors.red.withOpacity(0.4),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: AdminColors.red, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Sair',
                          style: TextStyle(
                            color: AdminColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatefulWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected;
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: active ? AdminColors.gradient : null,
            color: !active && hover ? AdminColors.card : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                color: active ? Colors.white : Colors.white60,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                widget.item.label,
                style: TextStyle(
                  color: active ? Colors.white : Colors.white70,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
