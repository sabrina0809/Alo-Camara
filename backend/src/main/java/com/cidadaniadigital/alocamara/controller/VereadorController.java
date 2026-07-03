package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.VereadorRequest;
import com.cidadaniadigital.alocamara.dto.VereadorResponse;
import com.cidadaniadigital.alocamara.service.VereadorService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import java.util.UUID;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/vereadores")
public class VereadorController {

    private final VereadorService service;

    public VereadorController(VereadorService service) {
        this.service = service;
    }

    @GetMapping
    public List<VereadorResponse> listar(
            @RequestParam(required = false) UUID camaraId,
            @RequestParam(required = false) Boolean ativos) {
        return service.listar(camaraId, ativos);
    }

    @GetMapping("/{id}")
    public VereadorResponse buscar(@PathVariable UUID id) {
        return service.buscarPorId(id);
    }

    @PostMapping
    public ResponseEntity<VereadorResponse> criar(@Valid @RequestBody VereadorRequest req) {
        VereadorResponse criado = service.criar(req);
        return ResponseEntity.created(URI.create("/api/vereadores/" + criado.id())).body(criado);
    }

    @PutMapping("/{id}")
    public VereadorResponse atualizar(@PathVariable UUID id, @Valid @RequestBody VereadorRequest req) {
        return service.atualizar(id, req);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable UUID id) {
        service.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
