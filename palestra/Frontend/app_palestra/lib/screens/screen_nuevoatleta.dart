import 'package:flutter/material.dart';
import 'package:app_palestra/models/model_atleta.dart';
import 'package:app_palestra/services/service_atletas.dart';

class ScreenNuevoatleta extends StatefulWidget {
  const ScreenNuevoatleta({super.key});

  @override
  State<ScreenNuevoatleta> createState() => _ScreenNuevoatletaState();
}

class _ScreenNuevoatletaState extends State<ScreenNuevoatleta> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nuevo Atleta"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese el nombre";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(
                  labelText: "Categoría",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese la categoría";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Crear atleta"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final atleta = ModelAtleta(
                        id: 0,
                        name: _nameController.text,
                        categoria: _categoriaController.text,
                      );

                      bool ok = await crearAtleta(atleta);

                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Atleta creado")),
                        );

                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error al crear atleta"),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
