import 'package:flutter/material.dart';
import 'package:flutter_crud_app/controller/database_controller.dart';
import 'package:flutter_crud_app/model/people_model.dart';

class PeopleController {
  Databasepadrao banco = Databasepadrao.instance;
  List<PeopleModel> peoples = [];

  Future<void> create(PeopleModel people, BuildContext context) async {
    try {
      await banco.insertData('PEOPLE', people);
    } catch (e) {
      _showErrorDialog('Erro ao criar pessoa: $e', context);
    }
  }

  Future<List<PeopleModel>> read(BuildContext context) async {
    try {
      var retorno = await banco.selectData('PEOPLE');
      if (retorno.isNotEmpty) {
        for (Map m in retorno) {
          peoples.add(PeopleModel.fromJson(m));
        }
      }
      return peoples;
    } catch (e) {
      _showErrorDialog('Erro ao recuperar pessoas: $e', context);
      return [];
    }
  }

  Future<void> update(
      PeopleModel people, String id, BuildContext context) async {
    try {
      await banco.updateData('PEOPLE', 'id', id, people);
    } catch (e) {
      _showErrorDialog('Erro ao atualizar pessoa: $e', context);
    }
  }

  Future<void> delete(int id, BuildContext context) async {
    try {
      await banco.deleteData('PEOPLE', 'id', id);
    } catch (e) {
      _showErrorDialog('Erro ao excluir pessoa: $e', context);
    }
  }

  void _showErrorDialog(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
