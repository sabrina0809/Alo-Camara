/// Modelo de Vereador alinhado com o DTO VereadorResponse do backend.
/// Usado quando ApiConfig.useMockData == false (consumo da API real).
class VereadorModel {
  final String id;
  final String? camaraId;
  final String nome;
  final String slug;
  final String? partido;
  final String? regiao;
  final String? fotoUrl;
  final String? biografia;
  final List<String> projetos;
  final String? emailGabinete;
  final String? telefoneGabinete;
  final bool ativo;

  const VereadorModel({
    required this.id,
    this.camaraId,
    required this.nome,
    required this.slug,
    this.partido,
    this.regiao,
    this.fotoUrl,
    this.biografia,
    this.projetos = const [],
    this.emailGabinete,
    this.telefoneGabinete,
    this.ativo = true,
  });

  factory VereadorModel.fromJson(Map<String, dynamic> json) {
    return VereadorModel(
      id: json['id'] as String,
      camaraId: json['camaraId'] as String?,
      nome: json['nome'] as String,
      slug: json['slug'] as String,
      partido: json['partido'] as String?,
      regiao: json['regiao'] as String?,
      fotoUrl: json['fotoUrl'] as String?,
      biografia: json['biografia'] as String?,
      projetos: (json['projetos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      emailGabinete: json['emailGabinete'] as String?,
      telefoneGabinete: json['telefoneGabinete'] as String?,
      ativo: json['ativo'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'camaraId': camaraId,
        'nome': nome,
        'slug': slug,
        'partido': partido,
        'regiao': regiao,
        'fotoUrl': fotoUrl,
        'biografia': biografia,
        'projetos': projetos,
        'emailGabinete': emailGabinete,
        'telefoneGabinete': telefoneGabinete,
        'ativo': ativo,
      };
}
