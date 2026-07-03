package com.cidadaniadigital.alocamara.domain.enums;

/**
 * Provedor de autenticação do cidadão.
 * Mapeia o enum public.auth_provider_enum (labels: email, google, govbr).
 * Os nomes das constantes DEVEM bater exatamente com os labels do Postgres.
 */
public enum AuthProvider {
    email,
    google,
    govbr
}
