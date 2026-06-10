import 'package:flutter/material.dart';
import 'widgets/admin_ui.dart';
import 'admin_shell.dart';

/// Login do Administrador — mesma identidade visual do login do cidadão,
/// porém com selo "Painel Administrativo".
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final email = TextEditingController();
  final senha = TextEditingController();
  bool hover = false;

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  void entrar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AdminShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AdminColors.deep, Color(0xFF0B1F3A)],
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
                const SizedBox(height: 12),
                const Text(
                  'Alô Câmara',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AdminColors.indigo.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AdminColors.indigo.withOpacity(0.5),
                    ),
                  ),
                  child: const Text(
                    'Painel Administrativo',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AdminColors.bg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AdminColors.stroke),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Entrar como administrador',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const FieldLabel('E-mail institucional'),
                      TextField(
                        controller: email,
                        style: const TextStyle(color: Colors.white),
                        decoration: adminField(
                          hint: 'admin@camara.gov.br',
                          icon: Icons.email,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const FieldLabel('Senha'),
                      TextField(
                        controller: senha,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: adminField(
                          hint: '••••••••',
                          icon: Icons.lock,
                        ),
                      ),
                      const SizedBox(height: 18),
                      MouseRegion(
                        onEnter: (_) => setState(() => hover = true),
                        onExit: (_) => setState(() => hover = false),
                        child: GestureDetector(
                          onTap: entrar,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: AdminColors.gradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: hover
                                  ? [
                                      BoxShadow(
                                        color: AdminColors.blue.withOpacity(
                                          0.5,
                                        ),
                                        blurRadius: 16,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: const Center(
                              child: Text(
                                'Acessar painel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Acesso restrito a servidores autorizados',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
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
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF22D3EE)],
        ),
        boxShadow: const [BoxShadow(color: Color(0xFF6366F1), blurRadius: 20)],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white70, width: 2),
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
