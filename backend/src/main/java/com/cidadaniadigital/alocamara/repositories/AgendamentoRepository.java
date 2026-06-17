package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.Agendamento;
import com.cidadaniadigital.alocamara.enums.StatusAgendamento;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
public interface AgendamentoRepository extends JpaRepository<Agendamento, UUID> {
    Optional<Agendamento> findByProtocolo(String protocolo);
    List<Agendamento> findByCidadaoId(UUID cidadaoId);
    List<Agendamento> findByVereadorId(UUID vereadorId);
    List<Agendamento> findByVereadorIdAndStatus(UUID vereadorId, StatusAgendamento status);
}
