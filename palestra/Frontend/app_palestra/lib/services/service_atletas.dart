import 'dart:convert';

import 'package:app_palestra/config/api_config.dart';
import 'package:app_palestra/models/model_atleta.dart';
import 'package:http/http.dart' as http;

Future<List<ModelAtleta>> getAtletas() async {
  final response = await http.get(Uri.parse("${ApiConfig.baseUrl}/atleta/all"));
  print('STATUS:${response.statusCode}');
  print('BODY:${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => ModelAtleta.fromJson(json)).toList();
  } else {
    throw Exception('Error en la carga de datos');
  }
}

Future<bool> actualizarAtleta(ModelAtleta atleta) async {
  final url = Uri.parse("${ApiConfig.baseUrl}/atleta/update/${atleta.id}");
  print("ID del atleta: ${atleta.id}");
  print('BODY:${atleta.toJson()}');
  final response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"name": atleta.name, "categoria": atleta.categoria}),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> crearAtleta(ModelAtleta atleta) async {
  final url = Uri.parse("${ApiConfig.baseUrl}/atleta/save");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"name": atleta.name, "categoria": atleta.categoria}),
  );

  return response.statusCode == 200 || response.statusCode == 201;
}

Future<bool> deleteAtleta(int id) async {
  final url = Uri.parse("${ApiConfig.baseUrl}/atleta/delete/$id");

  final response = await http.delete(url);

  return response.statusCode == 200;
}
