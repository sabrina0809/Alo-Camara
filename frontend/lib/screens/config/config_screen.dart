import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF8B5CF6),
                  ],
                ),
              ),

              child: Row(
                children: [

                  
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=3",
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "João Silva",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "h@h.com",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

           
            const _sectionTitle("Conta"),

            _item(
              icon: Icons.person,
              title: "Editar Perfil",
              subtitle: "Alterar informações pessoais",
            ),

            _item(
              icon: Icons.lock,
              title: "Alterar Senha",
              subtitle: "Atualizar senha de acesso",
            ),

            const SizedBox(height: 20),

           
            const _sectionTitle("Notificações"),

            _switchItem(
              icon: Icons.notifications,
              title: "Notificações Push",
              subtitle: "Receber alertas no celular",
              value: true,
            ),

            _switchItem(
              icon: Icons.email,
              title: "Notificações por E-mail",
              subtitle: "Receber atualizações no e-mail",
              value: false,
            ),

            const SizedBox(height: 20),

           
            const _sectionTitle("Aparência"),

            _switchItem(
              icon: Icons.dark_mode,
              title: "Modo Escuro",
              subtitle: "Ativar tema escuro",
              value: true,
            ),

            const SizedBox(height: 20),

            
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red.withOpacity(0.4)),
                ),

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text(
                      "Sair da conta",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            
            const Center(
              child: Text(
                "Prefeitura de Sarandi - Câmara de Vereadores",
                style: TextStyle(color: Colors.white38, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 6),

            const Center(
              child: Text(
                "Versão 1.0.0",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _sectionTitle extends StatelessWidget {
  final String title;

  const _sectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


Widget _item({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),

    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(14),
    ),

    child: Row(
      children: [

        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white70),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.white)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.white54)),
            ],
          ),
        ),

        const Icon(Icons.arrow_forward_ios,
            size: 14, color: Colors.white38),
      ],
    ),
  );
}


Widget _switchItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required bool value,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),

    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(14),
    ),

    child: Row(
      children: [

        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white70),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.white)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.white54)),
            ],
          ),
        ),

        Switch(
          value: value,
          onChanged: (_) {},
          activeColor: Colors.indigo,
        ),
      ],
    ),
  );
}