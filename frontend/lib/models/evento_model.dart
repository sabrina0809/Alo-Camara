/// Evento da agenda, alinhado com EventoAgendaResponse do backend.
class EventoModel {
  final String id;
  final String titulo;
  final String? descricao;
  final String categoria; // sessao | comissao | audiencia
  final DateTime dataHora;
  final String? local;
  final String status;

  const EventoModel({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.categoria,
    required this.dataHora,
    this.local,
    required this.status,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) {
    return EventoModel(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      categoria: json['categoria'] as String,
      dataHora: DateTime.parse(json['dataHora'] as String),
      local: json['local'] as String?,
      status: json['status'] as String? ?? 'agendada',
    );
  }

  /// Rótulo do tipo com acento, para exibição (bate com os filtros da tela).
  String get tipoLabel {
    switch (categoria) {
      case 'sessao':
        return 'Sessão';
      case 'comissao':
        return 'Comissão';
      case 'audiencia':
        return 'Audiência';
      default:
        return categoria;
    }
  }
}
