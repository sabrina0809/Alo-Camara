package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Cidadao;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CidadaoRepository extends JpaRepository<Cidadao, UUID> {

    Optional<Cidadao> findByEmail(String email);

    boolean existsByEmail(String email);
}
