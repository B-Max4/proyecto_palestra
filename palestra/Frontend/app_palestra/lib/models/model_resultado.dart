class ModelResultado {
  int? id;
  double? pts_boulder;
  double? pts_lead;
  double? pts_speed_calc;
  double? tiempo_speed;
  double? total_acumulado;
  int? id_atleta;

  ModelResultado({
    this.id,
    this.pts_boulder,
    this.pts_lead,
    this.pts_speed_calc,
    this.tiempo_speed,
    this.total_acumulado,
    this.id_atleta,
  });

  factory ModelResultado.fromJson(Map<String, dynamic> json) => ModelResultado(
    id: json['id'],
    pts_boulder: json['pts_boulder'],
    pts_lead: json['pts_lead'],
    pts_speed_calc: json['pts_speed_calc'],
    tiempo_speed: json['tiempo_speed'],
    total_acumulado: json['total_acumulado'],
    id_atleta: json['id_atleta'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pts_boulder': pts_boulder,
    'pts_lead': pts_lead,
    'pts_speed_calc': pts_speed_calc,
    'tiempo_speed': tiempo_speed,
    'total_acumulado': total_acumulado,
    'id_atleta': id_atleta,
  };
}
