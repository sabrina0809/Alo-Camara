class Vereador {
  final String nome;
  final String partido;
  final String foto;
  final String email;
  final String telefone;
  final String biografia;
  final List<String> projetos;

  Vereador({
    required this.nome,
    required this.partido,
    required this.foto,
    required this.email,
    required this.telefone,
    required this.biografia,
    required this.projetos,
  });
}

final List<Vereador> vereadores = [

  Vereador(
    nome: "João Carlos Silva",
    partido: "PSDB",
    foto: "assets/vereadores/joao.png",
    email: "joao.silva@camarasarandi.pr.gov.br",
    telefone: "(44) 3264-1234",
    biografia:
        "Vereador há 3 mandatos, defensor da educação e saúde pública. Formado em Direito pela UEM.",
    projetos: [
      "Projeto de Lei 045/2026 - Horta comunitária",
      "Projeto de Lei 032/2025 - Iluminação pública",
    ],
  ),

  Vereador(
    nome: "Maria Aparecida Souza",
    partido: "PT",
    foto: "assets/vereadores/maria.png",
    email: "maria.souza@camarasarandi.pr.gov.br",
    telefone: "(44) 3264-5678",
    biografia:
        "Atua fortemente na área social e defesa das mulheres. Assistente Social formada pela UEM.",
    projetos: [
      "Projeto de Lei 021/2026 - Casa da mulher",
      "Projeto de Lei 014/2025 - Creches municipais",
    ],
  ),

  Vereador(
    nome: "Carlos Henrique Lima",
    partido: "PL",
    foto: "assets/vereadores/carlos.png",
    email: "carlos.lima@camarasarandi.pr.gov.br",
    telefone: "(44) 3264-2222",
    biografia:
        "Foco em infraestrutura e mobilidade urbana. Engenheiro Civil.",
    projetos: [
      "Projeto de Lei 010/2026 - Asfalto em bairros periféricos",
      "Emenda 005/2025 - Pontes urbanas",
    ],
  ),

  Vereador(
    nome: "Ana Paula Ribeiro",
    partido: "MDB",
    foto: "assets/vereadores/ana.png",
    email: "ana.ribeiro@camarasarandi.pr.gov.br",
    telefone: "(44) 3264-3333",
    biografia:
        "Defensora da educação infantil e cultura local. Professora há 20 anos.",
    projetos: [
      "Projeto de Lei 033/2026 - Cultura nas escolas",
      "Projeto de Lei 022/2025 - Biblioteca comunitária",
    ],
  ),

  Vereador(
    nome: "Roberto Almeida",
    partido: "UNIÃO",
    foto: "assets/vereadores/roberto.png",
    email: "roberto.almeida@camarasarandi.pr.gov.br",
    telefone: "(44) 3264-4444",
    biografia:
        "Atua na segurança pública e combate à criminalidade. Ex-policial militar.",
    projetos: [
      "Projeto de Lei 015/2026 - Videomonitoramento urbano",
      "Projeto de Lei 009/2025 - Apoio à guarda municipal",
    ],
  ),
];