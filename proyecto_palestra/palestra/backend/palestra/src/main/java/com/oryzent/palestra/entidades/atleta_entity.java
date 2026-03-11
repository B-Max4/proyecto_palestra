package com.oryzent.palestra.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import java.util.List;

@Entity
@Table(name = "Atletas")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class atleta_entity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nombre", unique = false, nullable = false) // 2. Indicamos que la columna es "nombre"
    private String name;

    @Column(unique = false, nullable = false)
    private String categoria;

    @OneToMany(mappedBy = "atleta", cascade = CascadeType.ALL)
    private List<resultados_entity> resultados;

}
