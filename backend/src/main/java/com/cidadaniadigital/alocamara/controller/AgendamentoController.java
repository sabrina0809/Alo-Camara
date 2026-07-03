package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.AgendamentoRequest;
import com.cidadaniadigital.alocamara.dto.AgendamentoResponse;
import com.cidadaniadigital.alocamara.service.AgendamentoService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import java.util.UUID;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/agendamentos")
public class AgendamentoController {

    private final AgendamentoService service;

    public AgendamentoController(AgendamentoService service) {
        this.service = service;
    }

    @GetMapping
    public List<AgendamentoResponse> listar(@RequestParam(required = false) UUID cidadaoId) {
        return service.listar(cidadaoId);
    }

    @PostMapping
    public ResponseEntity<AgendamentoResponse> criar(@Valid @RequestBody AgendamentoRequest req) {
        AgendamentoResponse criado = service.criar(req);
        return ResponseEntity.created(URI.create("/api/agendamentos/" + criado.id())).body(criado);
    }
}
