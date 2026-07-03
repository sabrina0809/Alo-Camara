package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.EnqueteOpcao;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnqueteOpcaoRepository extends JpaRepository<EnqueteOpcao, UUID> {

    List<EnqueteOpcao> findByEnqueteIdOrderByOrdemAsc(UUID enqueteId);
}
