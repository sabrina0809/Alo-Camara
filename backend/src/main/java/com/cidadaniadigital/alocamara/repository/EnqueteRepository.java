package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Enquete;
import com.cidadaniadigital.alocamara.domain.enums.EnqueteStatus;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnqueteRepository extends JpaRepository<Enquete, UUID> {

    List<Enquete> findByCamaraId(UUID camaraId);

    List<Enquete> findByStatus(EnqueteStatus status);
}
