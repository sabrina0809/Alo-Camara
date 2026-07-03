import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/manifestacao_service.dart';

class SolicitacaoScreen extends StatefulWidget {
  const SolicitacaoScreen({super.key});

  @override
  State<SolicitacaoScreen> createState() => _SolicitacaoScreenState();
}

class _SolicitacaoScreenState extends State<SolicitacaoScreen> {
  final _formKey = GlobalKey<FormState>();

  String bairro = 'Centro';

  final TextEditingController endereco = TextEditingController();
  final TextEditingController descricao = TextEditingController();

  final ManifestacaoService _service = ManifestacaoService();
  bool _enviando = false;

  @override
  void dispose() {
    endereco.dispose();
    descricao.dispose();
    super.dispose();
  }

  Future<void> enviar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _enviando = true);
    try {
      final protocolo = await _service.criar(
        tipo: 'solicitacao',
        categoria: 'infraestrutura',
        descricao: 'Endereço: ${endereco.text}\n${descricao.text}',
        bairro: bairro,
      );
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Solicitação enviada'),
          content: Text('Seu protocolo: $protocolo'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar: $e')),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Solicitação de Serviço'),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              const Text(
                'Solicite serviços públicos como reparo de vias, limpeza, etc.',
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 10),

              const Text(
                'Ex: Reparo de calçada',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              const Text(
                'Selecione o bairro',
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: bairro,
                dropdownColor: AppColors.card,
                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                items: ['Centro', 'Zona Norte', 'Zona Sul']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),

                onChanged: (value) {
                  setState(() {
                    bairro = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: endereco,
                style: const TextStyle(color: Colors.white),

                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o endereço' : null,

                decoration: InputDecoration(
                  hintText: 'Rua, número, referência',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: descricao,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),

                validator: (value) =>
                    value == null || value.isEmpty ? 'Descreva a solicitação' : null,

                decoration: InputDecoration(
                  hintText: 'Descreva detalhadamente sua solicitação...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Atenção: Após o envio, você receberá um número de protocolo para acompanhamento. Mantenha-o guardado para consultas futuras.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _enviando ? null : enviar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _enviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Enviar Solicitação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}