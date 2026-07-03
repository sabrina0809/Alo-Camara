package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.Agendamento;
import com.cidadaniadigital.alocamara.domain.Cidadao;
import com.cidadaniadigital.alocamara.domain.Vereador;
import com.cidadaniadigital.alocamara.dto.AgendamentoRequest;
import com.cidadaniadigital.alocamara.dto.AgendamentoResponse;
import com.cidadaniadigital.alocamara.repository.AgendamentoRepository;
import com.cidadaniadigital.alocamara.repository.CidadaoRepository;
import com.cidadaniadigital.alocamara.repository.VereadorRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AgendamentoService {

    private final AgendamentoRepository repo;
    private final CidadaoRepository cidadaoRepo;
    private final VereadorRepository vereadorRepo;

    public AgendamentoService(AgendamentoRepository repo, CidadaoRepository cidadaoRepo,
            VereadorRepository vereadorRepo) {
        this.repo = repo;
        this.cidadaoRepo = cidadaoRepo;
        this.vereadorRepo = vereadorRepo;
    }

    @Transactional(readOnly = true)
    public List<AgendamentoResponse> listar(UUID cidadaoId) {
        List<Agendamento> lista = (cidadaoId != null)
                ? repo.findByCidadaoId(cidadaoId)
                : repo.findAll();
        return lista.stream().map(this::toResponse).toList();
    }

    @Transactional
    public AgendamentoResponse criar(AgendamentoRequest req) {
        Cidadao cidadao = cidadaoRepo.findById(req.cidadaoId())
                .orElseThrow(() -> new EntityNotFoundException("Cidadão não encontrado: " + req.cidadaoId()));
        Vereador vereador = vereadorRepo.findById(req.vereadorId())
                .orElseThrow(() -> new EntityNotFoundException("Vereador não encontrado: " + req.vereadorId()));
        Agendamento a = new Agendamento();
        a.setProtocolo("AGD-" + System.currentTimeMillis());
        a.setCidadao(cidadao);
        a.setVereador(vereador);
        a.setAssunto(req.assunto());
        a.setDescricao(req.descricao());
        a.setDataSolicitada(req.dataSolicitada());
        a.setLocal(req.local());
        return toResponse(repo.save(a));
    }

    private AgendamentoResponse toResponse(Agendamento a) {
        return new AgendamentoResponse(
                a.getId(), a.getProtocolo(),
                a.getCidadao() != null ? a.getCidadao().getId() : null,
                a.getVereador() != null ? a.getVereador().getId() : null,
                a.getAssunto(), a.getDescricao(), a.getDataSolicitada(),
                a.getDataConfirmada(), a.getStatus(), a.getLocal(),
                a.getCreatedAt(), a.getUpdatedAt());
    }
}
