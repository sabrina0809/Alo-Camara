package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Manifestacao;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoStatus;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ManifestacaoRepository extends JpaRepository<Manifestacao, UUID> {

    List<Manifestacao> findByCidadaoId(UUID cidadaoId);

    List<Manifestacao> findByVereadorId(UUID vereadorId);

    List<Manifestacao> findByStatus(ManifestacaoStatus status);

    Optional<Manifestacao> findByProtocolo(String protocolo);
}
