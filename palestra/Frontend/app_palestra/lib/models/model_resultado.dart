class ModelResultado {
  int? id;
  double pts_boulder;
  double pts_lead;
  double pts_speed_calc;
  String tiempo_speed;
  double total_acumulado;
  int? id_atleta;

  ModelResultado({
    this.id,
    required this.pts_boulder,
    required this.pts_lead,
    required this.pts_speed_calc,
    required this.tiempo_speed,
    required this.total_acumulado,
    this.id_atleta,
  });

  factory ModelResultado.fromJson(Map<String, dynamic> json) => ModelResultado(
    id: json['id'],
    pts_boulder: (json['pts_boulder'] ?? 0).toDouble(),
    pts_lead: (json['pts_lead'] ?? 0).toDouble(),
    pts_speed_calc: (json['pts_speed_calc'] ?? 0).toDouble(),
    tiempo_speed: json['tiempo_speed'] ?? "00:00:00",
    total_acumulado: (json['total_acumulado'] ?? 0).toDouble(),
    id_atleta: json['atleta']?['id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pts_boulder': pts_boulder,
    'pts_lead': pts_lead,
    'pts_speed_calc': pts_speed_calc,
    'tiempo_speed': tiempo_speed,
    'total_acumulado': total_acumulado,
    'atleta': {"id": id_atleta},
  };
}
