import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ReclamacaoScreen extends StatefulWidget {
  const ReclamacaoScreen({super.key});

  @override
  State<ReclamacaoScreen> createState() => _ReclamacaoScreenState();
}

class _ReclamacaoScreenState extends State<ReclamacaoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController bairroController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  void enviarReclamacao() {
    if (_formKey.currentState!.validate()) {
      String protocolo =
          "REC-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Reclamação enviada"),
          content: Text("Seu protocolo: $protocolo"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );

      bairroController.clear();
      enderecoController.clear();
      descricaoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Reclamação"),
        backgroundColor: AppColors.card,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              _campo("Bairro", bairroController),
              const SizedBox(height: 15),

              _campo("Rua, número e referência", enderecoController),
              const SizedBox(height: 15),

              _campo("Descreva sua reclamação...", descricaoController, maxLines: 5),

              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: enviarReclamacao,
                child: const Text("Enviar Reclamação"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      validator: (value) =>
          value == null || value.isEmpty ? "Campo obrigatório" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}