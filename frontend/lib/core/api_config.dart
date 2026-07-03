/// Configuração central da integração com o backend.
///
/// O INTERRUPTOR está aqui: enquanto [useMockData] for `true`, as telas
/// continuam usando os dados mockados. Troque para `false` quando o backend
/// estiver rodando e você quiser consumir a API real — nada mais precisa mudar
/// nas telas, apenas os services passam a chamar a rede.
class ApiConfig {
  /// Liga/desliga o modo mock. `true` = dados fixos nas telas.
  /// `false` = consome a API real (backend precisa estar rodando em [baseUrl]).
  static const bool useMockData = false;

  /// URL base da API REST (Spring Boot).
  ///
  /// - App desktop Windows / web: `http://localhost:8080/api`
  /// - Emulador Android: `http://10.0.2.2:8080/api`
  /// - Dispositivo físico: use o IP da máquina na rede (ex: http://192.168.x.x:8080/api)
  static const String baseUrl = 'http://localhost:8080/api';

  /// Timeout padrão das requisições.
  static const Duration timeout = Duration(seconds: 15);

  // --- Identidade "demo" enquanto não há login real ---
  // Usados pelos formulários para gravar no banco em nome de um cidadão/câmara
  // de demonstração. Substituir por dados do usuário autenticado no futuro.
  static const String demoCidadaoId = '9d8ef1fd-dd65-42f8-af2e-00739f5f3745';
  static const String demoCamaraId = '3f604732-e8d0-4d98-80fc-f5ce38f1cb79';
  static const String demoVereadorId = '97e7ceec-57c1-4fb6-8624-3c4c98aa522c';
}
