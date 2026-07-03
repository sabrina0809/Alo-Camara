package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.EnqueteRequest;
import com.cidadaniadigital.alocamara.dto.EnqueteResponse;
import com.cidadaniadigital.alocamara.dto.VotoRequest;
import com.cidadaniadigital.alocamara.service.EnqueteService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import java.util.UUID;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/enquetes")
public class EnqueteController {

    private final EnqueteService service;

    public EnqueteController(EnqueteService service) {
        this.service = service;
    }

    @GetMapping
    public List<EnqueteResponse> listar(@RequestParam(required = false) UUID camaraId) {
        return service.listar(camaraId);
    }

    @GetMapping("/{id}")
    public EnqueteResponse buscar(@PathVariable UUID id) {
        return service.buscar(id);
    }

    @PostMapping
    public ResponseEntity<EnqueteResponse> criar(@Valid @RequestBody EnqueteRequest req) {
        EnqueteResponse criada = service.criar(req);
        return ResponseEntity.created(URI.create("/api/enquetes/" + criada.id())).body(criada);
    }

    /** Registra o voto de um cidadão. */
    @PostMapping("/{id}/votos")
    public ResponseEntity<Void> votar(@PathVariable UUID id, @Valid @RequestBody VotoRequest req) {
        service.votar(id, req);
        return ResponseEntity.accepted().build();
    }
}
