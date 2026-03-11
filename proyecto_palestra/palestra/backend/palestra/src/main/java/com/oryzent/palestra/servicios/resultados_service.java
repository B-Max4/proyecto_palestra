package com.oryzent.palestra.servicios;

import com.oryzent.palestra.DTOs.resultados_DTO;

public interface resultados_service {

    public resultados_DTO saveResultados(resultados_DTO resultados);

    public resultados_DTO getResultados(Long id);

    public resultados_DTO updateResultados(Long id, resultados_DTO resultados);

    public void deleteResultados(Long id);

}
