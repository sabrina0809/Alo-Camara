package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.Vereador;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
public interface VereadorRepository extends JpaRepository<Vereador, UUID> {
    List<Vereador> findByCamaraIdAndAtivoTrue(UUID camaraId);
    Optional<Vereador> findBySlug(String slug);
}
