import 'package:flutter/material.dart';

import '../notificacoes/notificacoes_screen.dart';
import '../vereadores/vereadores_screen.dart';

import '../acoes/sugestao_screen.dart';
import '../acoes/solicitacao_screen.dart';
import '../acoes/reclamacao_screen.dart';
import '../acoes/denuncia_screen.dart';
import '../acoes/protocolos_screen.dart';
import '../acoes/elogio_screen.dart';

import '../acoes/solicitacoes_screen.dart';
import '../acoes/historico_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? hovered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      body: SafeArea(
        child: ListView(
          children: [

            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        'Olá, Cidadão ',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotificacoesScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: const Color(0xFF334155),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

               
                  MouseRegion(
                    onEnter: (_) => setState(() => hovered = 'vereador'),
                    onExit: (_) => setState(() => hovered = null),

                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VereadoresScreen(),
                          ),
                        );
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                          ),
                          boxShadow: hovered == 'vereador'
                              ? [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.6),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),

                        child: const Row(
                          children: [
                            Icon(Icons.groups, color: Colors.white),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Escolher Vereador\nVer todos os representantes',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Ações rápidas',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  _gridButtons(),

                  const SizedBox(height: 12),

                  _menuButton(
                    id: 'solicitacoes',
                    icon: Icons.list_alt,
                    text: 'Minhas Solicitações\nAcompanhe suas demandas',
                    page: SolicitacoesScreen(),
                  ),

                  const SizedBox(height: 12),

                  _menuButton(
                    id: 'historico',
                    icon: Icons.history_edu,
                    text: 'História da Câmara\nLinha do tempo',
                    page: HistoricoScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _gridButtons() {
    return Column(
      children: [

        Row(
          children: [
            Expanded(
              child: _card('Solicitação', Icons.add, Colors.blue,
                  SolicitacaoScreen()),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _card('Reclamação', Icons.warning, Colors.orange,
                  ReclamacaoScreen()),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _card('Sugestão', Icons.lightbulb, Colors.green,
                  SugestaoScreen()),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _card('Denúncia', Icons.report, Colors.red,
                  DenunciaScreen()),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _card('Elogio', Icons.thumb_up, Colors.pink,
                  ElogioScreen()),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _card('Protocolos', Icons.assignment, Colors.purple,
                  ProtocolosScreen()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _card(String id, IconData icon, Color color, Widget page) {
    final isHover = hovered == id;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = id),
      onExit: (_) => setState(() => hovered = null),

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 95,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            boxShadow: isHover
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 15,
                    )
                  ]
                : [],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(id, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton({
    required String id,
    required IconData icon,
    required String text,
    required Widget page,
  }) {
    final isHover = hovered == id;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = id),
      onExit: (_) => setState(() => hovered = null),

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            boxShadow: isHover
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 15,
                    )
                  ]
                : [],
          ),

          child: Row(
            children: [
              Icon(icon, color: Colors.cyan),
              const SizedBox(width: 12),
              Expanded(
                child: Text(text,
                    style: const TextStyle(color: Colors.white)),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}