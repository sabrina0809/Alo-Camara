package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.Camara;
import com.cidadaniadigital.alocamara.domain.Cidadao;
import com.cidadaniadigital.alocamara.domain.Enquete;
import com.cidadaniadigital.alocamara.domain.EnqueteOpcao;
import com.cidadaniadigital.alocamara.domain.EnqueteVoto;
import com.cidadaniadigital.alocamara.domain.Vereador;
import com.cidadaniadigital.alocamara.domain.enums.EnqueteStatus;
import com.cidadaniadigital.alocamara.dto.EnqueteOpcaoResult;
import com.cidadaniadigital.alocamara.dto.EnqueteRequest;
import com.cidadaniadigital.alocamara.dto.EnqueteResponse;
import com.cidadaniadigital.alocamara.dto.VotoRequest;
import com.cidadaniadigital.alocamara.repository.CamaraRepository;
import com.cidadaniadigital.alocamara.repository.CidadaoRepository;
import com.cidadaniadigital.alocamara.repository.EnqueteOpcaoRepository;
import com.cidadaniadigital.alocamara.repository.EnqueteRepository;
import com.cidadaniadigital.alocamara.repository.EnqueteVotoRepository;
import com.cidadaniadigital.alocamara.repository.VereadorRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EnqueteService {

    private final EnqueteRepository enqueteRepo;
    private final EnqueteOpcaoRepository opcaoRepo;
    private final EnqueteVotoRepository votoRepo;
    private final CamaraRepository camaraRepo;
    private final VereadorRepository vereadorRepo;
    private final CidadaoRepository cidadaoRepo;

    public EnqueteService(EnqueteRepository enqueteRepo, EnqueteOpcaoRepository opcaoRepo,
            EnqueteVotoRepository votoRepo, CamaraRepository camaraRepo,
            VereadorRepository vereadorRepo, CidadaoRepository cidadaoRepo) {
        this.enqueteRepo = enqueteRepo;
        this.opcaoRepo = opcaoRepo;
        this.votoRepo = votoRepo;
        this.camaraRepo = camaraRepo;
        this.vereadorRepo = vereadorRepo;
        this.cidadaoRepo = cidadaoRepo;
    }

    @Transactional(readOnly = true)
    public List<EnqueteResponse> listar(UUID camaraId) {
        List<Enquete> lista = (camaraId != null) ? enqueteRepo.findByCamaraId(camaraId) : enqueteRepo.findAll();
        return lista.stream().map(this::toResponse).toList();
    }

    @Transactional(readOnly = true)
    public EnqueteResponse buscar(UUID id) {
        return toResponse(enqueteRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Enquete não encontrada: " + id)));
    }

    @Transactional
    public EnqueteResponse criar(EnqueteRequest req) {
        Camara camara = camaraRepo.findById(req.camaraId())
                .orElseThrow(() -> new EntityNotFoundException("Câmara não encontrada: " + req.camaraId()));
        Enquete e = new Enquete();
        e.setCamara(camara);
        if (req.vereadorId() != null) {
            Vereador v = vereadorRepo.findById(req.vereadorId())
                    .orElseThrow(() -> new EntityNotFoundException("Vereador não encontrado: " + req.vereadorId()));
            e.setVereador(v);
        }
        e.setTitulo(req.titulo());
        e.setDescricao(req.descricao());
        e.setStatus(req.status() != null ? req.status() : EnqueteStatus.aberta);
        e.setDataInicio(req.dataInicio());
        e.setDataFim(req.dataFim());
        Enquete salva = enqueteRepo.save(e);

        short ordem = 0;
        for (String texto : req.opcoes()) {
            EnqueteOpcao o = new EnqueteOpcao();
            o.setEnquete(salva);
            o.setTexto(texto);
            o.setOrdem(ordem++);
            opcaoRepo.save(o);
        }
        return toResponse(salva);
    }

    @Transactional
    public void votar(UUID enqueteId, VotoRequest req) {
        Enquete enquete = enqueteRepo.findById(enqueteId)
                .orElseThrow(() -> new EntityNotFoundException("Enquete não encontrada: " + enqueteId));
        if (enquete.getStatus() != EnqueteStatus.aberta) {
            throw new IllegalArgumentException("A enquete não está aberta para votação.");
        }
        EnqueteOpcao opcao = opcaoRepo.findById(req.opcaoId())
                .orElseThrow(() -> new EntityNotFoundException("Opção não encontrada: " + req.opcaoId()));
        if (opcao.getEnquete() == null || !opcao.getEnquete().getId().equals(enqueteId)) {
            throw new IllegalArgumentException("A opção não pertence a esta enquete.");
        }
        Cidadao cidadao = cidadaoRepo.findById(req.cidadaoId())
                .orElseThrow(() -> new EntityNotFoundException("Cidadão não encontrado: " + req.cidadaoId()));
        if (votoRepo.existsByEnqueteIdAndCidadaoId(enqueteId, req.cidadaoId())) {
            throw new IllegalArgumentException("Este cidadão já votou nesta enquete.");
        }
        EnqueteVoto voto = new EnqueteVoto();
        voto.setEnquete(enquete);
        voto.setOpcao(opcao);
        voto.setCidadao(cidadao);
        votoRepo.save(voto);
    }

    private EnqueteResponse toResponse(Enquete e) {
        List<EnqueteOpcaoResult> opcoes = opcaoRepo.findByEnqueteIdOrderByOrdemAsc(e.getId()).stream()
                .map(o -> new EnqueteOpcaoResult(o.getId(), o.getTexto(), o.getOrdem(), votoRepo.countByOpcaoId(o.getId())))
                .toList();
        return new EnqueteResponse(
                e.getId(),
                e.getCamara() != null ? e.getCamara().getId() : null,
                e.getVereador() != null ? e.getVereador().getId() : null,
                e.getTitulo(), e.getDescricao(), e.getStatus(),
                e.getDataInicio(), e.getDataFim(), opcoes);
    }
}
