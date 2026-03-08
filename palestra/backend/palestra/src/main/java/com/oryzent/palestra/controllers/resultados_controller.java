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
import com.oryzent.palestra.servicios.resultados_service;
import com.oryzent.palestra.DTOs.resultados_DTO;

@RestController
@RequestMapping("/resultados")
public class resultados_controller {

    @Autowired
    private resultados_service resultados_service;

    @PostMapping("/save")
    public resultados_DTO saveResultados(@RequestBody resultados_DTO resultados) {
        return resultados_service.saveResultados(resultados);
    }

    @GetMapping("/get/{id}")
    public resultados_DTO getResultados(@PathVariable Long id) {
        return resultados_service.getResultados(id);
    }

    @PutMapping("/update/{id}")
    public resultados_DTO updateResultados(@PathVariable Long id, @RequestBody resultados_DTO resultados) {
        return resultados_service.updateResultados(id, resultados);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteResultados(@PathVariable Long id) {
        resultados_service.deleteResultados(id);
    }
}
