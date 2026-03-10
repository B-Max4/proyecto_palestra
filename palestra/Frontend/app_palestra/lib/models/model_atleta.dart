import 'package:app_palestra/models/model_resultado.dart';

class ModelAtleta {
  final int? id;
  String categoria;
  String name;
  List<ModelResultado>? resultados;

  ModelAtleta({
    this.id,
    required this.categoria,
    required this.name,
    this.resultados,
  });
  factory ModelAtleta.fromJson(Map<String, dynamic> json) {
    var listaResultados = json['resultados'] as List? ?? [];
    List<ModelResultado> resultadosConvertidos = listaResultados
        .map((e) => ModelResultado.fromJson(e))
        .toList();

    return ModelAtleta(
      id: json['id'],
      categoria: json['categoria'] ?? '',
      name: json['name'] ?? '',
      resultados: resultadosConvertidos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoria': categoria,
      'name': name,
      'resultados': resultados?.map((e) => e.toJson()).toList(),
    };
  }
}
