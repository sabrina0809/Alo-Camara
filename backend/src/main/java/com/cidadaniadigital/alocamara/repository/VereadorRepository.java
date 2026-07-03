package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Vereador;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VereadorRepository extends JpaRepository<Vereador, UUID> {

    List<Vereador> findByCamaraId(UUID camaraId);

    List<Vereador> findByAtivoTrue();

    Optional<Vereador> findBySlug(String slug);
}
