package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.UsuarioAdmin;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioAdminRepository extends JpaRepository<UsuarioAdmin, UUID> {

    Optional<UsuarioAdmin> findByEmail(String email);

    List<UsuarioAdmin> findByCamaraId(UUID camaraId);
}
