package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.Agendamento;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AgendamentoRepository extends JpaRepository<Agendamento, UUID> {

    List<Agendamento> findByCidadaoId(UUID cidadaoId);

    List<Agendamento> findByVereadorId(UUID vereadorId);

    Optional<Agendamento> findByProtocolo(String protocolo);
}
