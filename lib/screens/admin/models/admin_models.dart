import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// MODELOS DO PAINEL ADMINISTRATIVO
/// Por enquanto tudo é mock em memória (sem backend), seguindo o padrão atual
/// do projeto. Quando ligar à API, basta trocar as listas estáticas por
/// chamadas ao serviço, mantendo os mesmos modelos.
/// ---------------------------------------------------------------------------

/// Mensagem enviada por um cidadão (solicitação, reclamação, etc.).
class Mensagem {
  final String protocolo;
  String cidadao;
  String assunto; // referencia um Assunto.nome
  String mensagem;
  String status; // Pendente | Em andamento | Respondida | Arquivada
  String? resposta;
  final DateTime data;

  Mensagem({
    required this.protocolo,
    required this.cidadao,
    required this.assunto,
    required this.mensagem,
    this.status = 'Pendente',
    this.resposta,
    required this.data,
  });
}

/// Notícia / comunicado publicado pela Câmara.
class Noticia {
  String id;
  String titulo;
  String resumo;
  String conteudo;
  String categoria; // Geral | Sessão | Audiência | Comunicado
  bool publicado;
  DateTime data;

  Noticia({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.conteudo,
    required this.categoria,
    this.publicado = false,
    required this.data,
  });
}

/// Cadastro de vereador (versão admin, editável).
class VereadorAdmin {
  String id;
  String nome;
  String partido;
  String regiao;
  String email;
  String telefone;
  String biografia;
  bool ativo;

  VereadorAdmin({
    required this.id,
    required this.nome,
    required this.partido,
    required this.regiao,
    required this.email,
    required this.telefone,
    required this.biografia,
    this.ativo = true,
  });
}

/// Horário / evento da agenda da Câmara.
class Horario {
  String id;
  String titulo;
  String tipo; // Sessão | Comissão | Audiência
  String local;
  DateTime dataHora;
  bool ativo;

  Horario({
    required this.id,
    required this.titulo,
    required this.tipo,
    required this.local,
    required this.dataHora,
    this.ativo = true,
  });
}

/// Assunto geral (categoria usada para classificar mensagens/solicitações).
class Assunto {
  String id;
  String nome;
  String descricao;
  IconData icone;
  Color cor;
  bool ativo;

  Assunto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.icone,
    required this.cor,
    this.ativo = true,
  });
}

/// ---------------------------------------------------------------------------
/// "BANCO" EM MEMÓRIA
/// Listas compartilhadas pelas telas. Em um app real isso viraria um
/// repositório/serviço. Mantido simples e estático de propósito.
/// ---------------------------------------------------------------------------
class AdminData {
  static final List<Mensagem> mensagens = [
    Mensagem(
      protocolo: '2026-00123',
      cidadao: 'Carlos Eduardo',
      assunto: 'Iluminação Pública',
      mensagem:
          'Poste apagado há duas semanas na Rua das Flores, próximo ao nº 230.',
      status: 'Pendente',
      data: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Mensagem(
      protocolo: '2026-00118',
      cidadao: 'Fernanda Lopes',
      assunto: 'Saúde',
      mensagem: 'Falta de médicos na UBS do bairro Centro durante a tarde.',
      status: 'Em andamento',
      data: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Mensagem(
      protocolo: '2026-00097',
      cidadao: 'Roberto Nunes',
      assunto: 'Vias Públicas',
      mensagem: 'Buraco grande na Av. Brasil causando risco aos motociclistas.',
      status: 'Respondida',
      resposta: 'Equipe de tapa-buracos agendada para esta semana.',
      data: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  static final List<Noticia> noticias = [
    Noticia(
      id: 'n1',
      titulo: 'Sessão Extraordinária para votação do orçamento',
      resumo:
          'A Câmara realizará sessão extraordinária na próxima quinta-feira.',
      conteudo:
          'A Câmara Municipal convoca todos os vereadores para a sessão extraordinária '
          'destinada à votação do orçamento de 2026. A sessão é aberta ao público.',
      categoria: 'Sessão',
      publicado: true,
      data: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Noticia(
      id: 'n2',
      titulo: 'Audiência pública sobre saúde',
      resumo:
          'Participe da discussão sobre melhorias na rede municipal de saúde.',
      conteudo:
          'No dia 22, às 19h, ocorrerá audiência pública para debater investimentos '
          'na saúde do município. A população é convidada a contribuir.',
      categoria: 'Audiência',
      publicado: false,
      data: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  static final List<VereadorAdmin> vereadores = [
    VereadorAdmin(
      id: 'v1',
      nome: 'João Carlos Silva',
      partido: 'PSDB',
      regiao: 'Centro',
      email: 'joao.silva@camara.pr.gov.br',
      telefone: '(44) 3264-1234',
      biografia:
          'Vereador há 3 mandatos, defensor da educação e saúde pública.',
    ),
    VereadorAdmin(
      id: 'v2',
      nome: 'Maria Aparecida Souza',
      partido: 'PT',
      regiao: 'Norte',
      email: 'maria.souza@camara.pr.gov.br',
      telefone: '(44) 3264-5678',
      biografia: 'Atua na área social e defesa das mulheres.',
    ),
    VereadorAdmin(
      id: 'v3',
      nome: 'Carlos Henrique Lima',
      partido: 'PL',
      regiao: 'Sul',
      email: 'carlos.lima@camara.pr.gov.br',
      telefone: '(44) 3264-2222',
      biografia: 'Foco em infraestrutura e mobilidade urbana.',
      ativo: false,
    ),
  ];

  static final List<Horario> horarios = [
    Horario(
      id: 'h1',
      titulo: 'Sessão Ordinária',
      tipo: 'Sessão',
      local: 'Plenário Principal',
      dataHora: DateTime.now().add(const Duration(days: 1, hours: 9)),
    ),
    Horario(
      id: 'h2',
      titulo: 'Comissão de Finanças',
      tipo: 'Comissão',
      local: 'Sala 02',
      dataHora: DateTime.now().add(const Duration(days: 3, hours: 14)),
    ),
    Horario(
      id: 'h3',
      titulo: 'Audiência Pública - Saúde',
      tipo: 'Audiência',
      local: 'Auditório',
      dataHora: DateTime.now().add(const Duration(days: 6, hours: 19)),
    ),
  ];

  static final List<Assunto> assuntos = [
    Assunto(
      id: 'a1',
      nome: 'Iluminação Pública',
      descricao: 'Postes, lâmpadas e iluminação de vias.',
      icone: Icons.lightbulb,
      cor: const Color(0xFFF59E0B),
    ),
    Assunto(
      id: 'a2',
      nome: 'Saúde',
      descricao: 'UBS, atendimento e campanhas de saúde.',
      icone: Icons.local_hospital,
      cor: const Color(0xFFEF4444),
    ),
    Assunto(
      id: 'a3',
      nome: 'Vias Públicas',
      descricao: 'Asfalto, buracos, calçadas e sinalização.',
      icone: Icons.add_road,
      cor: const Color(0xFF3B82F6),
    ),
    Assunto(
      id: 'a4',
      nome: 'Educação',
      descricao: 'Escolas, creches e transporte escolar.',
      icone: Icons.school,
      cor: const Color(0xFF22C55E),
    ),
  ];
}
