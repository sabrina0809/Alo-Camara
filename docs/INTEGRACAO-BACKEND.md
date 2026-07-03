# Integração Front (Flutter) ↔ Backend (Spring Boot)

Este documento explica a "tomada" instalada dos dois lados e **como ligar** quando quiser
trocar os dados mockados pela API real.

## Estado atual

- **Backend:** completo e rodando (`http://localhost:8080`), conectado ao Supabase.
- **Front:** camada de dados instalada, mas **ainda usando mocks** (interruptor desligado).

## O interruptor único

Arquivo: [`frontend/lib/core/api_config.dart`](../frontend/lib/core/api_config.dart)

```dart
static const bool useMockData = true;  // ← troque para false para usar o backend real
```

Enquanto `true`, tudo funciona como hoje (dados fixos). Quando `false`, os services
passam a chamar a API. **As telas não mudam** — só os services.

## Como rodar os dois juntos

1. **Subir o backend** (a partir de `backend/`):
   ```bash
   ./mvnw.cmd spring-boot:run     # sobe em http://localhost:8080
   ```
2. **Rodar o front** (a partir de `frontend/`):
   ```bash
   flutter run -d windows
   ```
3. Trocar `useMockData` para `false` e dar hot restart (tecla `R`).

> Base URL por plataforma (em `api_config.dart`):
> - Windows/web: `http://localhost:8080/api`
> - Emulador Android: `http://10.0.2.2:8080/api`

## Arquitetura da camada de dados (front)

```
lib/
├── core/
│   ├── api_config.dart   # baseUrl + interruptor useMockData
│   └── api_client.dart   # wrapper http (get/post/put/delete + JSON)
├── models/
│   └── vereador_model.dart   # modelo com fromJson/toJson (MOLDE)
└── services/
    └── vereador_service.dart # service com fallback mock (MOLDE)
```

## Como adicionar um novo recurso (molde já pronto: vereador)

1. Criar `lib/models/<recurso>_model.dart` com `fromJson` batendo com o DTO do backend.
2. Criar `lib/services/<recurso>_service.dart` seguindo `vereador_service.dart`:
   - se `useMockData` → retorna mock;
   - senão → `_api.get('/<recurso>')`.
3. Na tela, trocar a lista hardcoded por `await <Recurso>Service().listar()`.

## Endpoints REST disponíveis

| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/api/vereadores` | Lista vereadores (`?camaraId=`, `?ativos=true`) |
| GET | `/api/vereadores/{id}` | Detalhe do vereador |
| POST | `/api/vereadores` | Cria vereador |
| GET | `/api/manifestacoes` | Lista manifestações (`?cidadaoId=`) |
| POST | `/api/manifestacoes` | Cria manifestação (gera protocolo) |
| GET | `/api/eventos` | Lista eventos da agenda (`?camaraId=`) |
| GET | `/api/comunicados` | Lista comunicados (`?publicados=true`) |
| POST | `/api/denuncias` | Cria denúncia anônima (gera protocolo) |
| GET | `/api/denuncias/{protocolo}` | Consulta denúncia por protocolo |
| GET | `/api/agendamentos` | Lista agendamentos (`?cidadaoId=`) |
| POST | `/api/agendamentos` | Cria agendamento (gera protocolo) |
| GET | `/api/vereadores/{id}/avaliacoes` | Lista avaliações moderadas do vereador |
| GET | `/api/vereadores/{id}/avaliacoes/media` | Média das notas (0-5) |
| POST | `/api/vereadores/{id}/avaliacoes` | Cria avaliação (entra pendente de moderação) |
| GET | `/api/enquetes` | Lista enquetes (`?camaraId=`) com apuração |
| GET | `/api/enquetes/{id}` | Detalhe da enquete + votos por opção |
| POST | `/api/enquetes` | Cria enquete com opções |
| POST | `/api/enquetes/{id}/votos` | Registra voto (1 por cidadão/enquete) |

Documentação interativa completa: **http://localhost:8080/swagger-ui/index.html**

## Observações

- O banco Supabase está **vazio** — os endpoints retornam `[]` até haver dados.
  Para ver conteúdo real no front, é preciso popular o banco (seed) ou criar via POST.
- Segurança: endpoints **abertos + CORS liberado** nesta fase. JWT (Supabase) fica
  para ativar depois (infra já declarada).
