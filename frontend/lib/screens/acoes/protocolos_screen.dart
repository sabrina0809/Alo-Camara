import 'package:flutter/material.dart';

class ProtocolosScreen extends StatelessWidget {
  const ProtocolosScreen({super.key});

  final List<Map<String, String>> protocolos = const [
    {
      "id": "#2024-00145",
      "tipo": "Sugestão",
      "titulo": "Construção de área de lazer no Jardim Paraíso",
      "status": "Em Andamento",
      "bairro": "Jardim Paraíso",
      "data": "20/03/2026",
      "descricao": "Projeto aprovado, em fase de licitação para execução.",
    },
    {
      "id": "#2024-00123",
      "tipo": "Solicitação",
      "titulo": "Reparo de buraco na Rua das Flores",
      "status": "Em Análise",
      "bairro": "Centro",
      "data": "10/04/2026",
      "descricao": "Aguardando vistoria técnica da Secretaria de Obras.",
    },
    {
      "id": "#2024-00089",
      "tipo": "Reclamação",
      "titulo": "Falta de iluminação na Av. Bandeirantes",
      "status": "Resolvido",
      "bairro": "Jardim Imperial",
      "data": "15/02/2026",
      "descricao": "Lâmpadas substituídas e sistema normalizado em 05/04/2026.",
    },
    {
      "id": "#2024-00167",
      "tipo": "Denúncia",
      "titulo": "Descarte irregular de lixo em terreno baldio",
      "status": "Em Andamento",
      "bairro": "Vila São Jorge",
      "data": "12/04/2026",
      "descricao": "Fiscalização realizada, proprietário notificado para limpeza.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        title: const Text("Meus Protocolos"),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

          
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar por protocolo ou assunto...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatusBox(title: "Total", value: "4"),
                _StatusBox(title: "Análise", value: "1"),
                _StatusBox(title: "Andamento", value: "2"),
                _StatusBox(title: "Resolvidos", value: "1"),
              ],
            ),

            const SizedBox(height: 12),

        
            Expanded(
              child: ListView.builder(
                itemCount: protocolos.length,

                itemBuilder: (context, index) {
                  final p = protocolos[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          p["id"]!,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          p["tipo"]!,
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          p["titulo"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [

                            _tag(p["status"]!),

                            const SizedBox(width: 8),

                            Text(
                              p["bairro"]!,
                              style: const TextStyle(color: Colors.white70),
                            ),

                            const Spacer(),

                            Text(
                              p["data"]!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          p["descricao"]!,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String status) {
    Color color = Colors.grey;

    if (status == "Em Andamento") color = Colors.orange;
    if (status == "Em Análise") color = Colors.blue;
    if (status == "Resolvido") color = Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}


class _StatusBox extends StatelessWidget {
  final String title;
  final String value;

  const _StatusBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}