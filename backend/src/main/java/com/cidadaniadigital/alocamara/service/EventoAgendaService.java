package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.EventoAgenda;
import com.cidadaniadigital.alocamara.dto.EventoAgendaResponse;
import com.cidadaniadigital.alocamara.repository.EventoAgendaRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EventoAgendaService {

    private final EventoAgendaRepository repo;

    public EventoAgendaService(EventoAgendaRepository repo) {
        this.repo = repo;
    }

    @Transactional(readOnly = true)
    public List<EventoAgendaResponse> listar(UUID camaraId) {
        List<EventoAgenda> lista = (camaraId != null)
                ? repo.findByCamaraIdOrderByDataHoraDesc(camaraId)
                : repo.findAll();
        return lista.stream().map(this::toResponse).toList();
    }

    @Transactional(readOnly = true)
    public EventoAgendaResponse buscar(UUID id) {
        return repo.findById(id).map(this::toResponse)
                .orElseThrow(() -> new EntityNotFoundException("Evento não encontrado: " + id));
    }

    private EventoAgendaResponse toResponse(EventoAgenda e) {
        return new EventoAgendaResponse(
                e.getId(),
                e.getCamara() != null ? e.getCamara().getId() : null,
                e.getTitulo(), e.getDescricao(), e.getCategoria(), e.getDataHora(),
                e.getLocal(), e.getLinkTransmissao(), e.getStatus(),
                e.getCreatedAt(), e.getUpdatedAt());
    }
}
