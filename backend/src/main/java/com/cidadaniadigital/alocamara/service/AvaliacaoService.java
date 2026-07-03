package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.AvaliacaoVereador;
import com.cidadaniadigital.alocamara.domain.Cidadao;
import com.cidadaniadigital.alocamara.domain.Vereador;
import com.cidadaniadigital.alocamara.dto.AvaliacaoRequest;
import com.cidadaniadigital.alocamara.dto.AvaliacaoResponse;
import com.cidadaniadigital.alocamara.repository.AvaliacaoVereadorRepository;
import com.cidadaniadigital.alocamara.repository.CidadaoRepository;
import com.cidadaniadigital.alocamara.repository.VereadorRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AvaliacaoService {

    private final AvaliacaoVereadorRepository repo;
    private final VereadorRepository vereadorRepo;
    private final CidadaoRepository cidadaoRepo;

    public AvaliacaoService(AvaliacaoVereadorRepository repo, VereadorRepository vereadorRepo,
            CidadaoRepository cidadaoRepo) {
        this.repo = repo;
        this.vereadorRepo = vereadorRepo;
        this.cidadaoRepo = cidadaoRepo;
    }

    /** Lista as avaliações JÁ MODERADAS (visíveis) de um vereador. */
    @Transactional(readOnly = true)
    public List<AvaliacaoResponse> listarModeradas(UUID vereadorId) {
        return repo.findByVereadorIdAndModeradoTrue(vereadorId).stream().map(this::toResponse).toList();
    }

    /** Média das notas moderadas de um vereador (0 se nenhuma). */
    @Transactional(readOnly = true)
    public double media(UUID vereadorId) {
        Double m = repo.mediaNotaByVereador(vereadorId);
        return m == null ? 0.0 : m;
    }

    @Transactional
    public AvaliacaoResponse criar(UUID vereadorId, AvaliacaoRequest req) {
        Vereador vereador = vereadorRepo.findById(vereadorId)
                .orElseThrow(() -> new EntityNotFoundException("Vereador não encontrado: " + vereadorId));
        Cidadao cidadao = cidadaoRepo.findById(req.cidadaoId())
                .orElseThrow(() -> new EntityNotFoundException("Cidadão não encontrado: " + req.cidadaoId()));
        if (repo.existsByVereadorIdAndCidadaoId(vereadorId, req.cidadaoId())) {
            throw new IllegalArgumentException("Este cidadão já avaliou este vereador.");
        }
        AvaliacaoVereador a = new AvaliacaoVereador();
        a.setVereador(vereador);
        a.setCidadao(cidadao);
        a.setNota(req.nota());
        a.setComentario(req.comentario());
        a.setModerado(false); // entra pendente de moderação
        return toResponse(repo.save(a));
    }

    private AvaliacaoResponse toResponse(AvaliacaoVereador a) {
        return new AvaliacaoResponse(
                a.getId(),
                a.getVereador() != null ? a.getVereador().getId() : null,
                a.getCidadao() != null ? a.getCidadao().getId() : null,
                a.getNota(), a.getComentario(), a.getModerado(), a.getCreatedAt());
    }
}
