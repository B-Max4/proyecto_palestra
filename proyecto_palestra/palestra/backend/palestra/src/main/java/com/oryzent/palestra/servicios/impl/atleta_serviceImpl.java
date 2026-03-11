package com.oryzent.palestra.servicios.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.oryzent.palestra.repositorios.atleta_repository;
import com.oryzent.palestra.mapper.atleta_mapper;
import com.oryzent.palestra.servicios.atleta_service;
import com.oryzent.palestra.DTOs.atleta_DTO;
import com.oryzent.palestra.entidades.atleta_entity;

@Service
public class atleta_serviceImpl implements atleta_service {

    @Autowired
    private atleta_repository atleta_repository;

    @Autowired
    private atleta_mapper atleta_mapper;

    @Override
    public atleta_DTO saveAtleta(atleta_DTO atleta) {
        atleta_entity atleta_entity = atleta_mapper.toEntity(atleta);
        atleta_repository.save(atleta_entity);
        return atleta_mapper.toDTO(atleta_entity);
    }

    @Override
    public atleta_DTO getAtleta(Long id) {
        atleta_entity atleta_entity = atleta_repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Atleta no encontrado"));
        return atleta_mapper.toDTO(atleta_entity);
    }

    @Override
    public atleta_DTO updateAtleta(Long id, atleta_DTO atleta) {
        atleta_entity atleta_entity = atleta_mapper.toEntity(atleta);
        atleta_entity.setId(id);
        atleta_repository.save(atleta_entity);
        return atleta_mapper.toDTO(atleta_entity);
    }

    @Override
    public void deleteAtleta(Long id) {
        atleta_repository.deleteById(id);
    }

    @Override
    public List<atleta_DTO> getAllAtletas() {
        return atleta_mapper.toDTOList(atleta_repository.findAll());
    }
}