package com.oryzent.palestra.DTOs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class resultados_DTO {

    private Long id;
    private double pts_boulder;
    private double pts_lead;
    private double tiempo_speed;
    private double pts_speed_calc;
    private double total_acumulado;
    private Long atleta_id;

}
