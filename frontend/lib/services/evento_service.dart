import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/evento_model.dart';

/// Service de eventos da agenda (leitura). Segue o molde do VereadorService.
class EventoService {
  final ApiClient _api;

  EventoService([ApiClient? api]) : _api = api ?? ApiClient();

  Future<List<EventoModel>> listar({String? camaraId}) async {
    if (ApiConfig.useMockData) {
      return const [];
    }
    final data = await _api.get('/eventos', query: {'camaraId': camaraId});
    return (data as List).map((e) => EventoModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
