package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.EventoAgenda;
import com.cidadaniadigital.alocamara.enums.StatusEvento;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
public interface EventoAgendaRepository extends JpaRepository<EventoAgenda, UUID> {
    List<EventoAgenda> findByCamaraIdOrderByDataHoraAsc(UUID camaraId);
    List<EventoAgenda> findByCamaraIdAndStatus(UUID camaraId, StatusEvento status);
    List<EventoAgenda> findByCamaraIdAndDataHoraAfter(UUID camaraId, OffsetDateTime from);
}
