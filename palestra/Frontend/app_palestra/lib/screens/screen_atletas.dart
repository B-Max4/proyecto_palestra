import 'package:flutter/material.dart';
import 'package:app_palestra/models/model_atleta.dart';
import 'package:app_palestra/services/service_atletas.dart';
import 'package:app_palestra/screens/screen_resultados.dart';

class listatletas extends StatefulWidget {
  const listatletas({super.key});

  @override
  State<listatletas> createState() => _listatletasState();
}

class _listatletasState extends State<listatletas> {
  List<ModelAtleta> _atletas = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _cargarAtletas();
  }

  void _cargarAtletas() async {
    print("recargando datos ...");
    final atletas = await getAtletas();

    setState(() {
      _atletas = atletas;
      _loading = false;
      print("datos cargados ...");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Atletas"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final creado = await Navigator.pushNamed(context, '/nuevoatleta');
          if (creado != null) {
            _cargarAtletas();
          }
        },
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _atletas.isEmpty
          ? const Center(child: Text('No se encontraron atletas'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _atletas.length,
              itemBuilder: (context, index) {
                final atleta = _atletas[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        atleta.name.isNotEmpty
                            ? atleta.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    title: Text(
                      atleta.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('Categoría: ${atleta.categoria}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () async {
                      // Navega a la pantalla de resultados y espera posibles cambios
                      final actualizado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ScreenResultados(atleta: atleta),
                        ),
                      );

                      // Si hubo cambios, actualiza el estado
                      if (actualizado == true) {
                        _cargarAtletas();
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
