package com.oryzent.palestra.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.oryzent.palestra.servicios.atleta_service;
import com.oryzent.palestra.DTOs.atleta_DTO;

@RestController
@RequestMapping("/atleta")
public class atleta_controller {

    @Autowired
    private atleta_service atleta_service;

    @PostMapping("/save")
    public atleta_DTO saveAtleta(@RequestBody atleta_DTO atleta) {
        return atleta_service.saveAtleta(atleta);
    }

    @GetMapping("/get/{id}")
    public atleta_DTO getAtleta(@PathVariable Long id) {
        return atleta_service.getAtleta(id);
    }

    @PutMapping("/update/{id}")
    public atleta_DTO updateAtleta(@PathVariable Long id, @RequestBody atleta_DTO atleta) {
        return atleta_service.updateAtleta(id, atleta);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteAtleta(@PathVariable Long id) {
        atleta_service.deleteAtleta(id);
    }
}
