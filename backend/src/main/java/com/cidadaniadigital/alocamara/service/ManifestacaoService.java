package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.Cidadao;
import com.cidadaniadigital.alocamara.domain.Manifestacao;
import com.cidadaniadigital.alocamara.domain.Vereador;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoTipo;
import com.cidadaniadigital.alocamara.dto.ManifestacaoRequest;
import com.cidadaniadigital.alocamara.dto.ManifestacaoResponse;
import com.cidadaniadigital.alocamara.repository.CidadaoRepository;
import com.cidadaniadigital.alocamara.repository.ManifestacaoRepository;
import com.cidadaniadigital.alocamara.repository.VereadorRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ManifestacaoService {

    private final ManifestacaoRepository repo;
    private final CidadaoRepository cidadaoRepo;
    private final VereadorRepository vereadorRepo;

    public ManifestacaoService(ManifestacaoRepository repo, CidadaoRepository cidadaoRepo,
            VereadorRepository vereadorRepo) {
        this.repo = repo;
        this.cidadaoRepo = cidadaoRepo;
        this.vereadorRepo = vereadorRepo;
    }

    @Transactional(readOnly = true)
    public List<ManifestacaoResponse> listar(UUID cidadaoId) {
        List<Manifestacao> lista = (cidadaoId != null)
                ? repo.findByCidadaoId(cidadaoId)
                : repo.findAll();
        return lista.stream().map(this::toResponse).toList();
    }

    @Transactional(readOnly = true)
    public ManifestacaoResponse buscar(UUID id) {
        return repo.findById(id).map(this::toResponse)
                .orElseThrow(() -> new EntityNotFoundException("Manifestação não encontrada: " + id));
    }

    @Transactional
    public ManifestacaoResponse criar(ManifestacaoRequest req) {
        Cidadao cidadao = cidadaoRepo.findById(req.cidadaoId())
                .orElseThrow(() -> new EntityNotFoundException("Cidadão não encontrado: " + req.cidadaoId()));
        Vereador vereador = vereadorRepo.findById(req.vereadorId())
                .orElseThrow(() -> new EntityNotFoundException("Vereador não encontrado: " + req.vereadorId()));

        Manifestacao m = new Manifestacao();
        m.setProtocolo(gerarProtocolo(req.tipo()));
        m.setCidadao(cidadao);
        m.setVereador(vereador);
        m.setTipo(req.tipo());
        m.setCategoria(req.categoria());
        m.setBairro(req.bairro());
        m.setDescricao(req.descricao());
        m.setAnexoUrl(req.anexoUrl());
        m.setLatitude(req.latitude());
        m.setLongitude(req.longitude());
        return toResponse(repo.save(m));
    }

    private String gerarProtocolo(ManifestacaoTipo tipo) {
        String prefixo = switch (tipo) {
            case solicitacao -> "SOL";
            case reclamacao -> "REC";
            case sugestao -> "SUG";
            case elogio -> "ELO";
        };
        return prefixo + "-" + System.currentTimeMillis();
    }

    private ManifestacaoResponse toResponse(Manifestacao m) {
        return new ManifestacaoResponse(
                m.getId(), m.getProtocolo(),
                m.getCidadao() != null ? m.getCidadao().getId() : null,
                m.getVereador() != null ? m.getVereador().getId() : null,
                m.getTipo(), m.getCategoria(), m.getBairro(), m.getDescricao(),
                m.getAnexoUrl(), m.getLatitude(), m.getLongitude(),
                m.getStatus(), m.getPrioridade(), m.getCreatedAt(), m.getUpdatedAt());
    }
}
