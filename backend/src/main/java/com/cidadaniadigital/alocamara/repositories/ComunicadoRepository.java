package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.Comunicado;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;
public interface ComunicadoRepository extends JpaRepository<Comunicado, UUID> {
    List<Comunicado> findByCamaraIdAndPublicadoTrueOrderByDataPublicacaoDesc(UUID camaraId);
    List<Comunicado> findByVereadorIdAndPublicadoTrue(UUID vereadorId);
}
