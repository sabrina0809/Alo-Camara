package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.AvaliacaoVereador;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AvaliacaoVereadorRepository extends JpaRepository<AvaliacaoVereador, UUID> {

    List<AvaliacaoVereador> findByVereadorIdAndModeradoTrue(UUID vereadorId);

    boolean existsByVereadorIdAndCidadaoId(UUID vereadorId, UUID cidadaoId);

    @Query("select coalesce(avg(a.nota), 0) from AvaliacaoVereador a "
            + "where a.vereador.id = :vereadorId and a.moderado = true")
    Double mediaNotaByVereador(UUID vereadorId);
}
