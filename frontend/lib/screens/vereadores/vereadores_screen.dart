import 'package:flutter/material.dart';
import '../models/vereador.dart';
import '../../services/vereador_service.dart';
import 'vereador_detail.dart';

class VereadoresScreen extends StatefulWidget {
  const VereadoresScreen({super.key});

  @override
  State<VereadoresScreen> createState() => _VereadoresScreenState();
}

class _VereadoresScreenState extends State<VereadoresScreen> {
  String selectedFilter = "Todas";

  final List<String> filters = [
    "Todas",
    "Centro",
    "Norte",
    "Sul",
    "Leste",
    "Oeste",
  ];

  final VereadorService _service = VereadorService();
  late Future<List<Vereador>> _future;

  @override
  void initState() {
    super.initState();
    _future = _carregar();
  }

  // Puxa do backend (ou do mock, conforme ApiConfig.useMockData) e converte
  // o VereadorModel da API para o model usado pela tela.
  Future<List<Vereador>> _carregar() async {
    final models = await _service.listar();
    return models
        .map((m) => Vereador(
              nome: m.nome,
              partido: m.partido ?? "—",
              regiao: m.regiao ?? "—",
              nota: 0.0,
              avaliacoes: 0,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        automaticallyImplyLeading: false,
        // Mostra "voltar" só quando a tela foi empurrada (ex: via "Escolher
        // Vereador"). Como aba do Dashboard, não há para onde voltar.
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          "Vereadores",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar por nome...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final f = filters[index];
                final selected = f == selectedFilter;
                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = f),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: selected ? Colors.indigo : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(f, style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<Vereador>>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Erro ao carregar vereadores:\n${snap.error}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  );
                }
                final lista = (snap.data ?? [])
                    .where((v) =>
                        selectedFilter == "Todas" || v.regiao == selectedFilter)
                    .toList();
                if (lista.isEmpty) {
                  return const Center(
                    child: Text("Nenhum vereador encontrado.",
                        style: TextStyle(color: Colors.white54)),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: lista.map(_card).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(Vereador v) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VereadorDetailScreen(vereador: v),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.indigo.withValues(alpha: 0.3),
              child: Text(
                v.nome.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(v.nome, style: const TextStyle(color: Colors.white)),
                  Text(v.partido,
                      style: const TextStyle(color: Colors.white70)),
                  Text(v.regiao,
                      style: const TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
