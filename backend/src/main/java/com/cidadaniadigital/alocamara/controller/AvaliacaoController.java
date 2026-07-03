package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.AvaliacaoRequest;
import com.cidadaniadigital.alocamara.dto.AvaliacaoResponse;
import com.cidadaniadigital.alocamara.service.AvaliacaoService;
import jakarta.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/vereadores/{vereadorId}/avaliacoes")
public class AvaliacaoController {

    private final AvaliacaoService service;

    public AvaliacaoController(AvaliacaoService service) {
        this.service = service;
    }

    /** Avaliações moderadas (visíveis) do vereador. */
    @GetMapping
    public List<AvaliacaoResponse> listar(@PathVariable UUID vereadorId) {
        return service.listarModeradas(vereadorId);
    }

    /** Média das notas moderadas. */
    @GetMapping("/media")
    public Map<String, Object> media(@PathVariable UUID vereadorId) {
        return Map.of("vereadorId", vereadorId, "media", service.media(vereadorId));
    }

    /** Cria uma avaliação (entra pendente de moderação). */
    @PostMapping
    public ResponseEntity<AvaliacaoResponse> criar(@PathVariable UUID vereadorId,
            @Valid @RequestBody AvaliacaoRequest req) {
        return ResponseEntity.status(201).body(service.criar(vereadorId, req));
    }
}
