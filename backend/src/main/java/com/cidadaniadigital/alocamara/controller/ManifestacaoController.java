package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.ManifestacaoRequest;
import com.cidadaniadigital.alocamara.dto.ManifestacaoResponse;
import com.cidadaniadigital.alocamara.service.ManifestacaoService;
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
@RequestMapping("/api/manifestacoes")
public class ManifestacaoController {

    private final ManifestacaoService service;

    public ManifestacaoController(ManifestacaoService service) {
        this.service = service;
    }

    @GetMapping
    public List<ManifestacaoResponse> listar(@RequestParam(required = false) UUID cidadaoId) {
        return service.listar(cidadaoId);
    }

    @GetMapping("/{id}")
    public ManifestacaoResponse buscar(@PathVariable UUID id) {
        return service.buscar(id);
    }

    @PostMapping
    public ResponseEntity<ManifestacaoResponse> criar(@Valid @RequestBody ManifestacaoRequest req) {
        ManifestacaoResponse criada = service.criar(req);
        return ResponseEntity.created(URI.create("/api/manifestacoes/" + criada.id())).body(criada);
    }
}
