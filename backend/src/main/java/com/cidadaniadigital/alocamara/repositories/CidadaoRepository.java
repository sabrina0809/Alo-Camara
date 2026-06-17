package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.Cidadao;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.UUID;
public interface CidadaoRepository extends JpaRepository<Cidadao, UUID> {
    Optional<Cidadao> findByEmail(String email);
    Optional<Cidadao> findByCpf(String cpf);
}
