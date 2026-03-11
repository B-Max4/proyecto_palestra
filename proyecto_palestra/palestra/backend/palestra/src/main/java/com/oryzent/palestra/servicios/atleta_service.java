package com.oryzent.palestra.servicios;

import java.util.List;

//interfaz del service
import com.oryzent.palestra.DTOs.atleta_DTO;

public interface atleta_service {

    public atleta_DTO saveAtleta(atleta_DTO atleta);

    public atleta_DTO getAtleta(Long id);

    public List<atleta_DTO> getAllAtletas();

    public atleta_DTO updateAtleta(Long id, atleta_DTO atleta);

    public void deleteAtleta(Long id);
}
