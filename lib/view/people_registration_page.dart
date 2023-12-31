import 'package:flutter/material.dart';

import 'package:flutter_crud_app/controller/people_controller.dart';
import 'package:flutter_crud_app/model/people_model.dart';

class PeopleRegistrationPage extends StatefulWidget {
  final PeopleModel? people;
  const PeopleRegistrationPage({
    Key? key,
    this.people,
  }) : super(key: key);

  @override
  PeopleRegistrationPageState createState() => PeopleRegistrationPageState();
}

class PeopleRegistrationPageState extends State<PeopleRegistrationPage> {
  PeopleController register = PeopleController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  late Future<void> future;
  List<PeopleModel> peoples = [];

  Future<void> initScreen() async {
    if (widget.people != null) {
      _nomeController.text = widget.people!.nome!;
      _ruaController.text = widget.people!.rua!;
      _cidadeController.text = widget.people!.cidade!;
      _estadoController.text = widget.people!.estado!;
    }
  }

  @override
  void initState() {
    super.initState();
    future = initScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLUTTER CRUD'),
        actions: [
          IconButton(
              onPressed: widget.people != null
                  ? () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text(
                                  'Deseja realmente deletar esse cadastro?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('CANCELAR'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    register.delete(
                                        widget.people!.id!, context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade600,
                                  ),
                                  child: const Text('DELETAR'),
                                ),
                              ],
                            );
                          });
                    }
                  : null,
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _ruaController,
              decoration: const InputDecoration(labelText: 'Rua'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _estadoController,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                PeopleModel people = PeopleModel(
                  id: widget.people?.id,
                  nome: _nomeController.text,
                  rua: _ruaController.text,
                  cidade: _cidadeController.text,
                  estado: _estadoController.text,
                );
                if (widget.people != null) {
                  register.update(
                      people, widget.people!.id!.toString(), context);
                } else {
                  register.create(people, context);
                }
                Navigator.pop(context);
              },
              child: Text(widget.people != null ? 'ATUALIZAR' : 'SALVAR'),
            ),
          ],
        ),
      ),
    );
  }
}
