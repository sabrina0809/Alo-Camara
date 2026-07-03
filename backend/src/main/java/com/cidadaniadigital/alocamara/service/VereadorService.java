package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.Camara;
import com.cidadaniadigital.alocamara.domain.Vereador;
import com.cidadaniadigital.alocamara.dto.VereadorRequest;
import com.cidadaniadigital.alocamara.dto.VereadorResponse;
import com.cidadaniadigital.alocamara.mapper.VereadorMapper;
import com.cidadaniadigital.alocamara.repository.CamaraRepository;
import com.cidadaniadigital.alocamara.repository.VereadorRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class VereadorService {

    private final VereadorRepository vereadorRepository;
    private final CamaraRepository camaraRepository;

    public VereadorService(VereadorRepository vereadorRepository, CamaraRepository camaraRepository) {
        this.vereadorRepository = vereadorRepository;
        this.camaraRepository = camaraRepository;
    }

    @Transactional(readOnly = true)
    public List<VereadorResponse> listar(UUID camaraId, Boolean apenasAtivos) {
        List<Vereador> vereadores;
        if (camaraId != null) {
            vereadores = vereadorRepository.findByCamaraId(camaraId);
        } else if (Boolean.TRUE.equals(apenasAtivos)) {
            vereadores = vereadorRepository.findByAtivoTrue();
        } else {
            vereadores = vereadorRepository.findAll();
        }
        return vereadores.stream().map(VereadorMapper::toResponse).toList();
    }

    @Transactional(readOnly = true)
    public VereadorResponse buscarPorId(UUID id) {
        return vereadorRepository.findById(id)
                .map(VereadorMapper::toResponse)
                .orElseThrow(() -> new EntityNotFoundException("Vereador não encontrado: " + id));
    }

    @Transactional
    public VereadorResponse criar(VereadorRequest req) {
        Camara camara = camaraRepository.findById(req.camaraId())
                .orElseThrow(() -> new EntityNotFoundException("Câmara não encontrada: " + req.camaraId()));
        Vereador v = new Vereador();
        aplicar(v, req, camara);
        return VereadorMapper.toResponse(vereadorRepository.save(v));
    }

    @Transactional
    public VereadorResponse atualizar(UUID id, VereadorRequest req) {
        Vereador v = vereadorRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Vereador não encontrado: " + id));
        Camara camara = camaraRepository.findById(req.camaraId())
                .orElseThrow(() -> new EntityNotFoundException("Câmara não encontrada: " + req.camaraId()));
        aplicar(v, req, camara);
        return VereadorMapper.toResponse(vereadorRepository.save(v));
    }

    @Transactional
    public void deletar(UUID id) {
        if (!vereadorRepository.existsById(id)) {
            throw new EntityNotFoundException("Vereador não encontrado: " + id);
        }
        vereadorRepository.deleteById(id);
    }

    private void aplicar(Vereador v, VereadorRequest req, Camara camara) {
        v.setCamara(camara);
        v.setNome(req.nome());
        v.setSlug(req.slug());
        v.setPartido(req.partido());
        v.setRegiao(req.regiao());
        v.setFotoUrl(req.fotoUrl());
        v.setBiografia(req.biografia());
        v.setProjetos(req.projetos());
        v.setEmailGabinete(req.emailGabinete());
        v.setTelefoneGabinete(req.telefoneGabinete());
        v.setMandatoInicio(req.mandatoInicio());
        v.setMandatoFim(req.mandatoFim());
        if (req.ativo() != null) {
            v.setAtivo(req.ativo());
        }
    }
}
