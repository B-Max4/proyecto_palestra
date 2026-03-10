package com.oryzent.palestra.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import jakarta.persistence.Column;
import java.time.LocalTime;

@Entity
@Table(name = "resultados")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class resultados_entity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = false, nullable = false)
    private double pts_boulder;

    @Column(unique = false, nullable = false)
    private double pts_lead;

    @Column(unique = false, nullable = false)
    private LocalTime tiempo_speed;

    @Column(unique = false, nullable = false)
    private double pts_speed_calc;

    @Column(unique = false, nullable = false)
    private double total_acumulado;

    @ManyToOne
    @JoinColumn(name = "id_atleta", nullable = false)
    private atleta_entity atleta;

}
