import 'package:flutter/material.dart';
import 'package:app_palestra/models/model_atleta.dart';
import 'package:app_palestra/models/model_resultado.dart';
import 'package:app_palestra/services/service_resultados.dart';

class ScreenResultados extends StatefulWidget {
  final ModelAtleta atleta;

  const ScreenResultados({super.key, required this.atleta});

  @override
  State<ScreenResultados> createState() => _ScreenResultadosState();
}

class _ScreenResultadosState extends State<ScreenResultados> {
  final _formKey = GlobalKey<FormState>();

  void _agregarResultado() {
    setState(() {
      widget.atleta.resultados!.add(
        ModelResultado(
          pts_boulder: 0,
          pts_lead: 0,
          pts_speed_calc: 0,
          tiempo_speed: "00:00:00",
          total_acumulado: 0,
          id_atleta: widget.atleta.id,
        ),
      );
    });
  }

  void _eliminarResultado(int index) {
    setState(() {
      widget.atleta.resultados!.removeAt(index);
    });
  }

  Future<void> _guardarResultados() async {
    print("boton guardar presionado");

    bool ok = true;

    for (var resultado in widget.atleta.resultados!) {
      resultado.id_atleta = widget.atleta.id;

      bool guardado;

      if (resultado.id == null) {
        print("Creando resultado nuevo");
        guardado = await crearResultado(resultado);
      } else {
        print("Actualizando resultado ${resultado.id}");
        guardado = await actualizarResultado(resultado);
      }

      if (!guardado) {
        ok = false;
        break;
      }
    }

    if (ok) {
      print("Todos los resultados guardados");
      Navigator.pop(context, true);
    } else {
      print("Error guardando resultados");
    }
  }

  @override
  Widget build(BuildContext context) {
    final atleta = widget.atleta;

    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados: ${atleta.name}"),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: atleta.resultados!.length,
          itemBuilder: (context, index) {
            final resultado = atleta.resultados![index];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Resultado ${index + 1}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarResultado(index),
                        ),
                      ],
                    ),

                    TextFormField(
                      initialValue: resultado.pts_boulder.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Puntos Boulder",
                      ),
                      onChanged: (value) {
                        resultado.pts_boulder = double.tryParse(value) ?? 0;
                      },
                    ),

                    TextFormField(
                      initialValue: resultado.pts_lead.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Puntos Lead",
                      ),
                      onChanged: (value) {
                        resultado.pts_lead = double.tryParse(value) ?? 0;
                      },
                    ),

                    TextFormField(
                      initialValue: resultado.pts_speed_calc.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Puntos Speed Calc",
                      ),
                      onChanged: (value) {
                        resultado.pts_speed_calc = double.tryParse(value) ?? 0;
                      },
                    ),

                    TextFormField(
                      initialValue: resultado.tiempo_speed,
                      decoration: const InputDecoration(
                        labelText: "Tiempo Speed (hh:mm:ss)",
                      ),
                      onChanged: (value) {
                        resultado.tiempo_speed = value;
                      },
                    ),

                    TextFormField(
                      initialValue: resultado.total_acumulado.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Total Acumulado",
                      ),
                      onChanged: (value) {
                        resultado.total_acumulado = double.tryParse(value) ?? 0;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "add",
            child: const Icon(Icons.add),
            onPressed: _agregarResultado,
          ),

          const SizedBox(height: 12),

          FloatingActionButton(
            heroTag: "save",
            backgroundColor: Colors.green,
            child: const Icon(Icons.save),
            onPressed: _guardarResultados,
          ),
        ],
      ),
    );
  }
}
