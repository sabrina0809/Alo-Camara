package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.Manifestacao;
import com.cidadaniadigital.alocamara.enums.StatusManifestacao;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
public interface ManifestacaoRepository extends JpaRepository<Manifestacao, UUID> {
    Optional<Manifestacao> findByProtocolo(String protocolo);
    List<Manifestacao> findByCidadaoId(UUID cidadaoId);
    List<Manifestacao> findByVereadorId(UUID vereadorId);
    List<Manifestacao> findByStatus(StatusManifestacao status);
}
