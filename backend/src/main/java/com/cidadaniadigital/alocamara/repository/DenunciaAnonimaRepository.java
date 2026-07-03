package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.DenunciaAnonima;
import com.cidadaniadigital.alocamara.domain.enums.DenunciaStatus;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DenunciaAnonimaRepository extends JpaRepository<DenunciaAnonima, UUID> {

    List<DenunciaAnonima> findByCamaraId(UUID camaraId);

    List<DenunciaAnonima> findByStatus(DenunciaStatus status);

    Optional<DenunciaAnonima> findByProtocolo(String protocolo);
}
