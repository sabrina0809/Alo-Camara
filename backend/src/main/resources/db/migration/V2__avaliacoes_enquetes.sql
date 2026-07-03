-- =====================================================================
-- V2 — Avaliações de vereador + Enquete consultiva
-- Fecha gaps da proposta (IDTNPR): "sistema de avaliações (moderadas)"
-- e "enquete consultiva para assuntos debatidos em sessão".
-- Aditivo, idempotente e reversível (rollback: DROP dos objetos abaixo).
-- =====================================================================

-- ---- Enum de status de enquete (guardado por idempotência) ----
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enquete_status_enum') THEN
        CREATE TYPE enquete_status_enum AS ENUM ('rascunho', 'aberta', 'encerrada');
    END IF;
END
$$;

-- ---- Avaliação de vereador (nota 1..5, moderada) ----
CREATE TABLE IF NOT EXISTS avaliacao_vereador (
    id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    vereador_id uuid NOT NULL REFERENCES vereador(id) ON DELETE CASCADE,
    cidadao_id  uuid NOT NULL REFERENCES cidadao(id) ON DELETE CASCADE,
    nota        smallint NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario  text,
    moderado    boolean NOT NULL DEFAULT false,
    created_at  timestamptz NOT NULL DEFAULT now(),
    updated_at  timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uq_avaliacao_vereador_cidadao UNIQUE (vereador_id, cidadao_id)
);
CREATE INDEX IF NOT EXISTS idx_avaliacao_vereador ON avaliacao_vereador (vereador_id);
CREATE INDEX IF NOT EXISTS idx_avaliacao_moderado ON avaliacao_vereador (moderado);

-- ---- Enquete consultiva ----
CREATE TABLE IF NOT EXISTS enquete (
    id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    camara_id   uuid NOT NULL REFERENCES camara(id) ON DELETE CASCADE,
    vereador_id uuid REFERENCES vereador(id) ON DELETE SET NULL,
    titulo      text NOT NULL,
    descricao   text,
    status      enquete_status_enum NOT NULL DEFAULT 'rascunho',
    data_inicio timestamptz,
    data_fim    timestamptz,
    created_at  timestamptz NOT NULL DEFAULT now(),
    updated_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_enquete_camara ON enquete (camara_id);
CREATE INDEX IF NOT EXISTS idx_enquete_status ON enquete (status);

-- ---- Opções de uma enquete ----
CREATE TABLE IF NOT EXISTS enquete_opcao (
    id         uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    enquete_id uuid NOT NULL REFERENCES enquete(id) ON DELETE CASCADE,
    texto      text NOT NULL,
    ordem      smallint NOT NULL DEFAULT 0,
    created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_enquete_opcao_enquete ON enquete_opcao (enquete_id);

-- ---- Voto do cidadão (1 voto por cidadão por enquete) ----
CREATE TABLE IF NOT EXISTS enquete_voto (
    id         uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    enquete_id uuid NOT NULL REFERENCES enquete(id) ON DELETE CASCADE,
    opcao_id   uuid NOT NULL REFERENCES enquete_opcao(id) ON DELETE CASCADE,
    cidadao_id uuid NOT NULL REFERENCES cidadao(id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uq_enquete_voto_cidadao UNIQUE (enquete_id, cidadao_id)
);
CREATE INDEX IF NOT EXISTS idx_enquete_voto_enquete ON enquete_voto (enquete_id);
CREATE INDEX IF NOT EXISTS idx_enquete_voto_opcao ON enquete_voto (opcao_id);

-- Documentação embutida
COMMENT ON TABLE avaliacao_vereador IS 'Avaliação (nota 1-5) do cidadão sobre um vereador, sujeita a moderação.';
COMMENT ON TABLE enquete IS 'Enquete consultiva para pautas de sessão (institucional ou de vereador).';
COMMENT ON TABLE enquete_opcao IS 'Opções de resposta de uma enquete.';
COMMENT ON TABLE enquete_voto IS 'Voto de um cidadão numa enquete (unico por cidadão/enquete).';
