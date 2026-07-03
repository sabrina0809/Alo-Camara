package com.cidadaniadigital.alocamara.repository;

import com.cidadaniadigital.alocamara.domain.RespostaManifestacao;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RespostaManifestacaoRepository extends JpaRepository<RespostaManifestacao, UUID> {

    List<RespostaManifestacao> findByManifestacaoIdOrderByCreatedAtAsc(UUID manifestacaoId);
}
