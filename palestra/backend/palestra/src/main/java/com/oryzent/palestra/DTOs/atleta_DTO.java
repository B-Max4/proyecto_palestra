package com.oryzent.palestra.DTOs;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class atleta_DTO {
    private Long id;
    private String name;
    private String categoria;
    private List<resultados_DTO> resultados;

}
