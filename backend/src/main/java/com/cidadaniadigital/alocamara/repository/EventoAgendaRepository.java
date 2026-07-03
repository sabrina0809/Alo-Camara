package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.EventoAgenda;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventoAgendaRepository extends JpaRepository<EventoAgenda, UUID> {

    List<EventoAgenda> findByCamaraIdOrderByDataHoraDesc(UUID camaraId);
}
