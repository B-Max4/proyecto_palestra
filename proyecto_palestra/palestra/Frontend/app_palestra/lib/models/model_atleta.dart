class ModelAtleta {
  int? id;
  String? categoria;
  String? name;

  ModelAtleta({this.id, this.categoria, this.name});

  factory ModelAtleta.fromJson(Map<String, dynamic> json) => ModelAtleta(
    id: json['id'],
    categoria: json['categoria'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoria': categoria,
    'name': name,
  };
}
