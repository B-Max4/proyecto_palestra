package com.oryzent.palestra.servicios;

//interfaz del service
import com.oryzent.palestra.DTOs.atleta_DTO;

public interface atleta_service {

    public atleta_DTO saveAtleta(atleta_DTO atleta);

    public atleta_DTO getAtleta(Long id);

    public atleta_DTO updateAtleta(Long id, atleta_DTO atleta);

    public void deleteAtleta(Long id);
}
