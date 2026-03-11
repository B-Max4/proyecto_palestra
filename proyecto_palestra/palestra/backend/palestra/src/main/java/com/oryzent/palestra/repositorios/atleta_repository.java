package com.oryzent.palestra.repositorios;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.oryzent.palestra.entidades.atleta_entity;

public interface atleta_repository extends JpaRepository<atleta_entity, Long> {

    atleta_entity findByName(String name);

    List<atleta_entity> findAll();
}
