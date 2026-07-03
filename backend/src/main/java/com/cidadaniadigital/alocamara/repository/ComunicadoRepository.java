package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Comunicado;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComunicadoRepository extends JpaRepository<Comunicado, UUID> {

    List<Comunicado> findByCamaraId(UUID camaraId);

    List<Comunicado> findByPublicadoTrueOrderByDataPublicacaoDesc();
}
