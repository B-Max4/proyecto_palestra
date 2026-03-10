import 'package:app_palestra/services/service_atletas.dart' as service_atletas;
import 'package:flutter/material.dart';
import 'package:app_palestra/models/model_atleta.dart';

class ScreenEditarAtleta extends StatefulWidget {
  const ScreenEditarAtleta({super.key});

  @override
  State<ScreenEditarAtleta> createState() => _ScreenEditarAtletaState();
}

class _ScreenEditarAtletaState extends State<ScreenEditarAtleta> {
  final _formKey = GlobalKey<FormState>();

  late ModelAtleta atleta;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    atleta = ModalRoute.of(context)!.settings.arguments as ModelAtleta;

    _nameController.text = atleta.name;
    _categoriaController.text = atleta.categoria;
  }

  void _confirmarBorrado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar atleta"),
        content: const Text("¿Seguro que desea eliminar este atleta?"),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),

          TextButton(
            child: const Text("Eliminar"),
            onPressed: () async {
              Navigator.pop(context);
              await service_atletas.deleteAtleta(atleta.id!);
              if (!mounted) return;

              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Atleta"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _confirmarBorrado,
          ),
        ],
      ),

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
                  child: const Text("Guardar cambios"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      atleta.name = _nameController.text;
                      atleta.categoria = _categoriaController.text;
                      bool ok = await service_atletas.actualizarAtleta(atleta);
                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Atleta actualizado")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Error al actualizar")),
                        );
                      }

                      Navigator.pop(context, atleta);
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
