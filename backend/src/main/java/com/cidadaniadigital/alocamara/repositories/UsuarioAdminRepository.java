package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.UsuarioAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
public interface UsuarioAdminRepository extends JpaRepository<UsuarioAdmin, UUID> {
    Optional<UsuarioAdmin> findByEmail(String email);
    List<UsuarioAdmin> findByCamaraId(UUID camaraId);
}
