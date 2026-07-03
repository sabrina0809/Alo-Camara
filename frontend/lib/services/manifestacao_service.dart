import '../core/api_client.dart';
import '../core/api_config.dart';

/// Service de manifestações (escrita). Usado pelos formulários de
/// Solicitação / Reclamação / Sugestão / Elogio.
class ManifestacaoService {
  final ApiClient _api;

  ManifestacaoService([ApiClient? api]) : _api = api ?? ApiClient();

  /// Cria uma manifestação e retorna o protocolo gerado pelo backend.
  ///
  /// [tipo]: solicitacao | reclamacao | sugestao | elogio
  /// [categoria]: saude | educacao | infraestrutura | seguranca | atendimento | outro
  Future<String> criar({
    required String tipo,
    required String categoria,
    required String descricao,
    String? bairro,
    String? vereadorId,
    String? cidadaoId,
  }) async {
    final data = await _api.post('/manifestacoes', {
      'cidadaoId': cidadaoId ?? ApiConfig.demoCidadaoId,
      'vereadorId': vereadorId ?? ApiConfig.demoVereadorId,
      'tipo': tipo,
      'categoria': categoria,
      'descricao': descricao,
      'bairro': bairro,
    });
    return (data as Map<String, dynamic>)['protocolo'] as String;
  }
}
