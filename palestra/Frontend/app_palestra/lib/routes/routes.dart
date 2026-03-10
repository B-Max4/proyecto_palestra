import 'package:app_palestra/screens/screem_editarAtleta.dart';
import 'package:app_palestra/screens/screen_bienvenida.dart';
import 'package:app_palestra/screens/screen_atletas.dart';
import 'package:app_palestra/screens/screen_nuevoatleta.dart';
import 'package:flutter/material.dart';

class Approutes {
  static const String bienvenida = '/bienvenida';
  static const String atletas = '/atletas';
  static const String nuevoatleta = '/nuevoatleta';
  static const String Editaratleta = '/editar_atleta';

  static Map<String, WidgetBuilder> get routes => {
    bienvenida: (context) => const ScreenBienvenida(),
    nuevoatleta: (context) => const ScreenNuevoatleta(),
    atletas: (context) => const listatletas(),
    //resultados: (context) => const ScreenResultados(),
    Editaratleta: (context) => const ScreenEditarAtleta(),
  };
}
