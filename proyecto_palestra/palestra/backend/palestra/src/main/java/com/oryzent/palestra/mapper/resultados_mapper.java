package com.oryzent.palestra.mapper;

import com.oryzent.palestra.entidades.atleta_entity;
import com.oryzent.palestra.entidades.resultados_entity;
import com.oryzent.palestra.DTOs.resultados_DTO;
import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface resultados_mapper {

    @Mapping(target = "atleta", source = "atleta_id")
    resultados_entity toEntity(resultados_DTO dto);

    @Mapping(target = "atleta_id", source = "atleta.id")
    resultados_DTO toDTO(resultados_entity entity);

    List<resultados_entity> toEntityList(List<resultados_DTO> dtos);

    List<resultados_DTO> toDTOList(List<resultados_entity> entities);

    default atleta_entity map(Long atleta_id) {
        if (atleta_id == null) {
            return null;
        }
        atleta_entity atleta = new atleta_entity();
        atleta.setId(atleta_id);
        return atleta;
    }
}
