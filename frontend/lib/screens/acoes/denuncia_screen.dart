import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class DenunciaScreen extends StatefulWidget {
  const DenunciaScreen({super.key});

  @override
  State<DenunciaScreen> createState() => _DenunciaScreenState();
}

class _DenunciaScreenState extends State<DenunciaScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController bairroController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  void enviarDenuncia() {
    if (_formKey.currentState!.validate()) {
      String protocolo =
          "DEN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Denúncia enviada"),
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
      localController.clear();
      descricaoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Denúncia"),
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

              _campo("Local da denúncia", localController),
              const SizedBox(height: 15),

              _campo("Descreva a denúncia...", descricaoController, maxLines: 6),

              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: enviarDenuncia,
                child: const Text("Enviar Denúncia"),
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