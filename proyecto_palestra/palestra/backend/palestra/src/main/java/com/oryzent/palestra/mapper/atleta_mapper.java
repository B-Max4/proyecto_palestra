package com.oryzent.palestra.mapper;

import com.oryzent.palestra.entidades.atleta_entity;
import com.oryzent.palestra.DTOs.atleta_DTO;
import java.util.List;

import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = resultados_mapper.class)
public interface atleta_mapper {

    atleta_entity toEntity(atleta_DTO dto);

    atleta_DTO toDTO(atleta_entity entity);

    List<atleta_entity> toEntityList(List<atleta_DTO> dtos);

    List<atleta_DTO> toDTOList(List<atleta_entity> entities);
}
