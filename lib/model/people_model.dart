class PeopleModel {
  int? id;
  String? nome;
  String? rua;
  String? cidade;
  String? estado;

  PeopleModel({
    this.id,
    this.nome,
    this.rua,
    this.cidade,
    this.estado,
  });

  PeopleModel.fromJson(Map json) {
    id = json['id'];
    nome = json['nome'];
    rua = json['rua'];
    cidade = json['cidade'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'rua': rua,
      'cidade': cidade,
      'estado': estado,
    };
  }

  static const sqlPeople = '''
                              CREATE TABLE PEOPLE (
                                  id              INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                                  nome            TEXT,
                                  rua             TEXT,
                                  cidade          TEXT,
                                  estado          TEXT
                              );
                            ''';
}
