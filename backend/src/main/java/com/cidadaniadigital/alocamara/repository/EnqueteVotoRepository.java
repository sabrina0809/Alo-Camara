package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.EnqueteVoto;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnqueteVotoRepository extends JpaRepository<EnqueteVoto, UUID> {

    boolean existsByEnqueteIdAndCidadaoId(UUID enqueteId, UUID cidadaoId);

    long countByOpcaoId(UUID opcaoId);
}
