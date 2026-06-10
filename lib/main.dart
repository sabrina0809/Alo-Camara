import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alô Câmara',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
      ),
      // Tela inicial: seletor de perfil (Cidadão / Administrador).
      home: const PerfilSelectScreen(),
    );
  }
}

/// Tela de escolha de perfil ao abrir o app.
/// Cidadão  -> LoginScreen (fluxo já existente)
/// Administrador -> AdminLoginScreen (painel web)
class PerfilSelectScreen extends StatelessWidget {
  const PerfilSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF020617), Color(0xFF0B1F3A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(),
                const SizedBox(height: 14),
                const Text(
                  'Alô Câmara',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Como deseja entrar?',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 28),
                _PerfilCard(
                  icon: Icons.person,
                  titulo: 'Cidadão',
                  descricao: 'Solicitações, notícias e agenda da Câmara',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                ),
                const SizedBox(height: 14),
                _PerfilCard(
                  icon: Icons.admin_panel_settings,
                  titulo: 'Administrador',
                  descricao:
                      'Gerenciar mensagens, notícias, vereadores e horários',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF22D3EE)],
        ),
        boxShadow: const [BoxShadow(color: Color(0xFF6366F1), blurRadius: 20)],
      ),
      child: const Icon(Icons.account_balance, color: Colors.white, size: 34),
    );
  }
}

class _PerfilCard extends StatefulWidget {
  final IconData icon;
  final String titulo;
  final String descricao;
  final VoidCallback onTap;
  const _PerfilCard({
    required this.icon,
    required this.titulo,
    required this.descricao,
    required this.onTap,
  });

  @override
  State<_PerfilCard> createState() => _PerfilCardState();
}

class _PerfilCardState extends State<_PerfilCard> {
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
          width: 360,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
            boxShadow: hover
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
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
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.descricao,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
