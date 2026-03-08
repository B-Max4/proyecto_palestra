package com.oryzent.palestra.servicios.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.oryzent.palestra.repositorios.resultados_repository;
import com.oryzent.palestra.mapper.resultados_mapper;
import com.oryzent.palestra.servicios.resultados_service;
import com.oryzent.palestra.DTOs.resultados_DTO;
import com.oryzent.palestra.entidades.resultados_entity;

@Service
public class resultados_serviceImpl implements resultados_service {

    @Autowired
    private resultados_repository resultados_repository;

    @Autowired
    private resultados_mapper resultados_mapper;

    @Override
    public resultados_DTO saveResultados(resultados_DTO resultados) {
        resultados_entity resultados_entity = resultados_mapper.toEntity(resultados);
        resultados_repository.save(resultados_entity);
        return resultados_mapper.toDTO(resultados_entity);
    }

    @Override
    public resultados_DTO getResultados(Long id) {
        resultados_entity resultados_entity = resultados_repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Resultados no encontrados"));
        return resultados_mapper.toDTO(resultados_entity);
    }

    @Override
    public resultados_DTO updateResultados(Long id, resultados_DTO resultados) {
        resultados_entity resultados_entity = resultados_mapper.toEntity(resultados);
        resultados_entity.setId(id);
        resultados_repository.save(resultados_entity);
        return resultados_mapper.toDTO(resultados_entity);
    }

    @Override
    public void deleteResultados(Long id) {
        resultados_repository.deleteById(id);
    }
}
