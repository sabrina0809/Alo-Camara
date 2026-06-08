import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SugestaoScreen extends StatefulWidget {
  const SugestaoScreen({super.key});

  @override
  State<SugestaoScreen> createState() => _SugestaoScreenState();
}

class _SugestaoScreenState extends State<SugestaoScreen> {
  final _formKey = GlobalKey<FormState>();

  String bairro = 'Centro';

  final TextEditingController endereco = TextEditingController();
  final TextEditingController descricao = TextEditingController();

  @override
  void dispose() {
    endereco.dispose();
    descricao.dispose();
    super.dispose();
  }

  void enviar() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Sugestão enviada com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sugestão'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              const Text(
                'Contribua com ideias para melhorar nossa cidade.',
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 10),

              const Text(
                'Ex: Área de lazer',
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
                    value == null || value.isEmpty ? 'Descreva a sugestão' : null,
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
                'Após o envio, você receberá um número de protocolo.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: enviar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Enviar Solicitação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}