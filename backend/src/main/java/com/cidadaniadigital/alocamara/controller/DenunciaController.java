package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.DenunciaRequest;
import com.cidadaniadigital.alocamara.dto.DenunciaResponse;
import com.cidadaniadigital.alocamara.service.DenunciaService;
import jakarta.validation.Valid;
import java.net.URI;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/denuncias")
public class DenunciaController {

    private final DenunciaService service;

    public DenunciaController(DenunciaService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<DenunciaResponse> criar(@Valid @RequestBody DenunciaRequest req) {
        DenunciaResponse criada = service.criar(req);
        return ResponseEntity.created(URI.create("/api/denuncias/" + criada.protocolo())).body(criada);
    }

    @GetMapping("/{protocolo}")
    public DenunciaResponse consultar(@PathVariable String protocolo) {
        return service.buscarPorProtocolo(protocolo);
    }
}
