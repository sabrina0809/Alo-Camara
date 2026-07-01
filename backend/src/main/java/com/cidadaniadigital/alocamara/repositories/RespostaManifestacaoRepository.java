package com.cidadaniadigital.alocamara.repositories;
import com.cidadaniadigital.alocamara.models.RespostaManifestacao;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;
public interface RespostaManifestacaoRepository extends JpaRepository<RespostaManifestacao, UUID> {
    List<RespostaManifestacao> findByManifestacaoIdOrderByCreatedAtAsc(UUID manifestacaoId);
    List<RespostaManifestacao> findByManifestacaoIdAndVisivelCidadaoTrue(UUID manifestacaoId);
}
