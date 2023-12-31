import 'package:flutter/material.dart';
import 'package:flutter_crud_app/controller/people_controller.dart';
import 'package:flutter_crud_app/model/people_model.dart';
import 'package:flutter_crud_app/view/people_registration_page.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({super.key});

  @override
  PeopleListPageState createState() => PeopleListPageState();
}

class PeopleListPageState extends State<PeopleListPage> {
  late Future<void> future;
  List<PeopleModel> peoples = [];

  Future<void> initScreen() async {
    PeopleController register = PeopleController();
    peoples = await register.read(context);
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
        title: const Text('FLUTTER CRUD LIST'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: peoples.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var item = peoples[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return PeopleRegistrationPage(people: item);
                                },
                              ),
                            );
                            setState(() {
                              future = initScreen();
                            });
                          },
                          child: ListTile(
                            title: Text(
                              '${item.id.toString()} - ${item.nome!}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.rua.toString()),
                                Text(item.cidade.toString()),
                                Text(item.estado.toString()),
                                Text(item.id.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return const PeopleRegistrationPage();
              },
            ),
          );
          setState(() {
            future = initScreen();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
