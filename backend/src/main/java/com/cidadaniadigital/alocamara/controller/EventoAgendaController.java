package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.EventoAgendaResponse;
import com.cidadaniadigital.alocamara.service.EventoAgendaService;
import java.util.List;
import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/eventos")
public class EventoAgendaController {

    private final EventoAgendaService service;

    public EventoAgendaController(EventoAgendaService service) {
        this.service = service;
    }

    @GetMapping
    public List<EventoAgendaResponse> listar(@RequestParam(required = false) UUID camaraId) {
        return service.listar(camaraId);
    }

    @GetMapping("/{id}")
    public EventoAgendaResponse buscar(@PathVariable UUID id) {
        return service.buscar(id);
    }
}
