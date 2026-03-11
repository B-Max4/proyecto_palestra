import 'dart:convert';
import 'package:app_palestra/config/api_config.dart';
import 'package:http/http.dart' as http;
import '../models/model_resultado.dart';

Future<bool> actualizarResultado(ModelResultado resultado) async {
  final url = Uri.parse(
    "${ApiConfig.baseUrl}/resultados/update/${resultado.id}",
  );

  final response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(resultado.toJson()),
  );
  print("STATUS:${response.statusCode}");
  print("BODY:${response.body}");
  print("ID atleta:${resultado.id_atleta}");
  print(jsonEncode(resultado.toJson()));
  return response.statusCode == 200;
}

Future<bool> crearResultado(ModelResultado resultado) async {
  final url = Uri.parse("${ApiConfig.baseUrl}/resultados/save");

  print("CREANDO RESULTADO");
  print(jsonEncode(resultado.toJson()));

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(resultado.toJson()),
  );

  print("STATUS:${response.statusCode}");
  print("BODY:${response.body}");

  return response.statusCode == 200 || response.statusCode == 201;
}

Future<bool> eliminarResultado(int id) async {
  final response = await http.delete(
    Uri.parse("${ApiConfig.baseUrl}/resultados/delete/$id"),
  );

  return response.statusCode == 200;
}
