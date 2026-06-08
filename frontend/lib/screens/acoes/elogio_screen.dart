import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ElogioScreen extends StatefulWidget {
  const ElogioScreen({super.key});

  @override
  State<ElogioScreen> createState() => _ElogioScreenState();
}

class _ElogioScreenState extends State<ElogioScreen> {
  String? vereador;
  String? categoria;
  bool usarLocalizacao = false;

  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Elogio'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Preencha os campos abaixo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

        
            _dropdown(
              label: 'Vereador (opcional)',
              value: vereador,
              items: const [
                'João Carlos Silva',
                'Maria Aparecida Souza',
                'Carlos Henrique Lima',
              ],
              onChanged: (v) => setState(() => vereador = v),
            ),

            const SizedBox(height: 15),

       
            _dropdown(
              label: 'Categoria',
              value: categoria,
              items: const [
                'Educação',
                'Saúde',
                'Infraestrutura',
                'Atendimento',
                'Segurança',
              ],
              onChanged: (v) => setState(() => categoria = v),
            ),

            const SizedBox(height: 15),

          
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
              ),

              child: TextField(
                controller: descricaoController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),

                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Descreva sua solicitação detalhadamente...',
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white70),
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
            ),

            const SizedBox(height: 15),

           
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anexar Imagem (opcional)',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Clique para enviar uma foto\nPNG, JPG até 10MB',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Localização',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Automático via GPS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  Switch(
                    value: usarLocalizacao,
                    activeColor: Colors.pink,
                    onChanged: (v) {
                      setState(() => usarLocalizacao = v);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

          
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Elogio enviado com sucesso!'),
                    ),
                  );
                },

                child: const Text(
                  'Enviar Elogio',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),

      child: DropdownButton<String>(
        value: value,
        hint: Text(label, style: const TextStyle(color: Colors.white70)),
        isExpanded: true,
        underline: const SizedBox(),

        dropdownColor: AppColors.card,
        style: const TextStyle(color: Colors.white),

        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),

        onChanged: onChanged,
      ),
    );
  }
}