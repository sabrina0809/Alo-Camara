package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Camara;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CamaraRepository extends JpaRepository<Camara, UUID> {
}
