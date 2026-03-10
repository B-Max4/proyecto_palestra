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
  print("ID atleta:$AsciiDecoder(){resultado.id_atleta}");
  print(jsonEncode(resultado.toJson()));
  return response.statusCode == 200;
}
