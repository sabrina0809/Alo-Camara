package com.cidadaniadigital.alocamara.controller;

import com.cidadaniadigital.alocamara.dto.ComunicadoResponse;
import com.cidadaniadigital.alocamara.service.ComunicadoService;
import java.util.List;
import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/comunicados")
public class ComunicadoController {

    private final ComunicadoService service;

    public ComunicadoController(ComunicadoService service) {
        this.service = service;
    }

    @GetMapping
    public List<ComunicadoResponse> listar(
            @RequestParam(required = false) UUID camaraId,
            @RequestParam(required = false) Boolean publicados) {
        return service.listar(camaraId, publicados);
    }
}
