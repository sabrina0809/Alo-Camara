package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.DenunciaAnonima;
import com.cidadaniadigital.alocamara.enums.StatusDenuncia;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
public interface DenunciaAnonimaRepository extends JpaRepository<DenunciaAnonima, UUID> {
    Optional<DenunciaAnonima> findByProtocolo(String protocolo);
    List<DenunciaAnonima> findByCamaraId(UUID camaraId);
    List<DenunciaAnonima> findByCamaraIdAndStatus(UUID camaraId, StatusDenuncia status);
}
