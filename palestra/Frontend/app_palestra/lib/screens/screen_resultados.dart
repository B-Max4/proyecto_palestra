import 'package:flutter/material.dart';
import 'package:app_palestra/models/model_atleta.dart';
import 'package:app_palestra/services/service_resultados.dart';

class ScreenResultados extends StatefulWidget {
  final ModelAtleta atleta;

  const ScreenResultados({super.key, required this.atleta});

  @override
  State<ScreenResultados> createState() => _ScreenResultadosState();
}

class _ScreenResultadosState extends State<ScreenResultados> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final atleta = widget.atleta;

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados: ${atleta.name}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              final actualizado = await Navigator.pushNamed(
                context,
                '/editar_atleta',
                arguments: atleta,
              );

              if (actualizado == true) {
                Navigator.pop(context, true);
              }
            },
          ),
        ],
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resultado ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Boulder
                    TextFormField(
                      initialValue: resultado.pts_boulder.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Puntos Boulder',
                      ),
                      onChanged: (value) =>
                          resultado.pts_boulder = double.tryParse(value) ?? 0,
                    ),

                    // Lead
                    TextFormField(
                      initialValue: resultado.pts_lead.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Puntos Lead',
                      ),
                      onChanged: (value) =>
                          resultado.pts_lead = double.tryParse(value) ?? 0,
                    ),

                    // Speed Calc
                    TextFormField(
                      initialValue: resultado.pts_speed_calc.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Puntos Speed Calc',
                      ),
                      onChanged: (value) => resultado.pts_speed_calc =
                          double.tryParse(value) ?? 0,
                    ),

                    // Tiempo Speed
                    TextFormField(
                      initialValue: resultado.tiempo_speed,
                      decoration: const InputDecoration(
                        labelText: 'Tiempo Speed (hh:mm:ss)',
                      ),
                      onChanged: (value) => resultado.tiempo_speed = value,
                    ),

                    // Total acumulado
                    TextFormField(
                      initialValue: resultado.total_acumulado.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Total Acumulado',
                      ),
                      onChanged: (value) => resultado.total_acumulado =
                          double.tryParse(value) ?? 0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            bool ok = true;

            for (var resultado in atleta.resultados!) {
              resultado.id_atleta = atleta.id;
              bool actualizado = await actualizarResultado(resultado);
              if (!actualizado) {
                ok = false;
              }
            }

            if (!mounted) return;

            if (ok) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Resultados actualizados')),
              );

              Navigator.pop(context, true);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error al actualizar resultados')),
              );
            }
          }
        },
      ),
    );
  }
}
