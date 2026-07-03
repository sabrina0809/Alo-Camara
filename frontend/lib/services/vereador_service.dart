import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/vereador_model.dart';

/// Service de Vereadores — MOLDE de referência para os demais services.
///
/// Enquanto [ApiConfig.useMockData] for `true`, retorna a lista mockada
/// (mesmo comportamento atual das telas). Quando virar `false`, passa a
/// consumir GET /api/vereadores do backend. As telas chamam sempre os mesmos
/// métodos — a troca é transparente.
class VereadorService {
  final ApiClient _api;

  VereadorService([ApiClient? api]) : _api = api ?? ApiClient();

  /// Lista vereadores (opcionalmente filtrando por câmara ou só ativos).
  Future<List<VereadorModel>> listar({String? camaraId, bool? ativos}) async {
    if (ApiConfig.useMockData) {
      return _mock;
    }
    final data = await _api.get('/vereadores', query: {
      'camaraId': camaraId,
      'ativos': ativos,
    });
    return (data as List).map((e) => VereadorModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Busca um vereador por id.
  Future<VereadorModel> buscar(String id) async {
    if (ApiConfig.useMockData) {
      return _mock.firstWhere((v) => v.id == id, orElse: () => _mock.first);
    }
    final data = await _api.get('/vereadores/$id');
    return VereadorModel.fromJson(data as Map<String, dynamic>);
  }

  // ---- Dados mock (fallback enquanto o backend não é usado) ----
  static const List<VereadorModel> _mock = [
    VereadorModel(
      id: 'mock-1',
      nome: 'Vereador Exemplo',
      slug: 'vereador-exemplo',
      partido: 'PARTIDO',
      regiao: 'Centro',
      ativo: true,
    ),
  ];
}
