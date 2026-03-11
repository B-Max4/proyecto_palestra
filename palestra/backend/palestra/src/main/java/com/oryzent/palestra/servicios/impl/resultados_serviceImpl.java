package com.oryzent.palestra.servicios.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.oryzent.palestra.repositorios.resultados_repository;
import com.oryzent.palestra.mapper.resultados_mapper;
import com.oryzent.palestra.servicios.resultados_service;
import com.oryzent.palestra.DTOs.resultados_DTO;
import com.oryzent.palestra.entidades.atleta_entity;
import com.oryzent.palestra.entidades.resultados_entity;
import com.oryzent.palestra.repositorios.atleta_repository;

@Service
public class resultados_serviceImpl implements resultados_service {

    @Autowired
    private resultados_repository resultados_repository;

    @Autowired
    private atleta_repository atleta_repository;

    @Autowired
    private resultados_mapper resultados_mapper;

    // @Override
    // public resultados_DTO saveResultados(resultados_DTO resultados) {
    // resultados_entity resultados_entity = resultados_mapper.toEntity(resultados);
    // resultados_repository.save(resultados_entity);
    // return resultados_mapper.toDTO(resultados_entity);
    // }
    @Override
    public resultados_DTO saveResultados(resultados_DTO resultados) {

        // 1. Convertimos los campos básicos (puntos, tiempo) del DTO a la Entidad
        resultados_entity entity = resultados_mapper.toEntity(resultados);

        // 2. Usamos el DTO para obtener el ID y buscar al atleta en la BD
        // Nota: Usamos getAtleta_id() porque así se llama tu variable en el DTO
        atleta_entity atleta = atleta_repository
                .findById(resultados.getId_atleta())
                .orElseThrow(() -> new RuntimeException("Atleta no encontrado"));

        // 3. Le "inyectamos" el atleta real a la entidad antes de guardar
        entity.setAtleta(atleta);

        // 4. Guardamos
        resultados_repository.save(entity);

        // 5. Devolvemos el DTO actualizado (por si el ID de la entidad se generó ahora)
        return resultados_mapper.toDTO(entity);
    }

    @Override
    public resultados_DTO getResultados(Long id) {
        resultados_entity resultados_entity = resultados_repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Resultados no encontrados"));
        return resultados_mapper.toDTO(resultados_entity);
    }

    @Override
    public resultados_DTO updateResultados(Long id, resultados_DTO resultados) {

        resultados_entity resultadoExistente = resultados_repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Resultado no encontrado"));

        // actualizar campos
        resultadoExistente.setPts_boulder(resultados.getPts_boulder());
        resultadoExistente.setPts_lead(resultados.getPts_lead());
        resultadoExistente.setPts_speed_calc(resultados.getPts_speed_calc());
        resultadoExistente.setTiempo_speed(resultados.getTiempo_speed());
        resultadoExistente.setTotal_acumulado(resultados.getTotal_acumulado());

        resultados_repository.save(resultadoExistente);

        return resultados_mapper.toDTO(resultadoExistente);
    }

    @Override
    public void deleteResultados(Long id) {
        resultados_repository.deleteById(id);
    }
}
