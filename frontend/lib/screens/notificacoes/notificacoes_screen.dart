import 'package:flutter/material.dart';

class NotificacoesScreen extends StatefulWidget {
  const NotificacoesScreen({super.key});

  @override
  State<NotificacoesScreen> createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<NotificacoesScreen> {

  String filtro = "Todas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        automaticallyImplyLeading: false,
        title: const Text("Notificações"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Marcar todas como lidas",
              style: TextStyle(color: Colors.blueAccent),
            ),
          )
        ],
      ),

      body: Column(
        children: [

          const SizedBox(height: 10),

        
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _filtro("Todas"),
                _filtro("Protocolos"),
                _filtro("Avisos"),
              ],
            ),
          ),

          const SizedBox(height: 10),

         
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                _notificacao(
                  titulo: "Protocolo #2024-00123 atualizado",
                  descricao: "Sua solicitação de reparo de via pública foi encaminhada para análise técnica.",
                  tempo: "há 9 dias",
                  nova: true,
                  tipo: "Protocolos",
                ),

                _notificacao(
                  titulo: "Sessão Extraordinária amanhã",
                  descricao: "A Câmara realizará sessão extraordinária às 18h para votação do orçamento.",
                  tempo: "há 9 dias",
                  nova: true,
                  tipo: "Avisos",
                ),

                _notificacao(
                  titulo: "Protocolo #2024-00089 resolvido",
                  descricao: "Sua reclamação sobre iluminação pública foi solucionada.",
                  tempo: "há 10 dias",
                  nova: false,
                  tipo: "Protocolos",
                ),

                _notificacao(
                  titulo: "Audiência Pública - Saúde",
                  descricao: "Participe da discussão sobre melhorias na saúde pública no dia 22/04.",
                  tempo: "há 11 dias",
                  nova: false,
                  tipo: "Avisos",
                ),

                _notificacao(
                  titulo: "Protocolo #2024-00145 em andamento",
                  descricao: "Sua sugestão sobre área de lazer foi aprovada e está em fase de planejamento.",
                  tempo: "há 12 dias",
                  nova: false,
                  tipo: "Protocolos",
                ),
              ].where((n) {
                if (filtro == "Todas") return true;
                return n.tipo == filtro;
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _filtro(String label) {
    final selected = filtro == label;

    return GestureDetector(
      onTap: () => setState(() => filtro = label),

      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),

        decoration: BoxDecoration(
          color: selected ? Colors.indigo : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
        ),

        alignment: Alignment.center,

        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class _notificacao extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String tempo;
  final bool nova;
  final String tipo;

  const _notificacao({
    required this.titulo,
    required this.descricao,
    required this.tempo,
    required this.nova,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {

    Color cor;
    IconData icone;

    if (tipo == "Protocolos") {
      cor = Colors.blue;
      icone = Icons.assignment;
    } else {
      cor = Colors.orange;
      icone = Icons.campaign;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF1E293B),
      ),

      child: Row(
        children: [

       
          Container(
            width: 5,
            height: 110,
            decoration: BoxDecoration(
              color: cor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      // 🔹 ÍCONE
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: cor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icone, color: cor, size: 18),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          titulo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      if (nova)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: cor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Nova",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    descricao,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        tempo,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),

                      Text(
                        tipo,
                        style: TextStyle(
                          color: cor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
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
    );
  }
}