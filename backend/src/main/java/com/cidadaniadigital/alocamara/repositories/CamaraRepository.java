package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.Camara;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;
public interface CamaraRepository extends JpaRepository<Camara, UUID> {}
