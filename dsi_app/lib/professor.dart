import 'package:dsi_app/constants.dart';
import 'package:dsi_app/dsi_widgets.dart';
import 'package:dsi_app/infra.dart';
import 'package:dsi_app/pessoa.dart';
import 'package:flutter/material.dart';

class Professor extends Pessoa {
  String idDisciplina;
  String idLattes;

  Professor({cpf, nome, endereco, this.idDisciplina, this.idLattes})
      : super(cpf: cpf, nome: nome, endereco: endereco);

  Professor.fromJson(Map<String, dynamic> json)
  : idDisciplina = json['idDisciplina'],
  super.fromJson(json);

  ///TIP este método converte o objeto atual para um mapa que representa um
  ///objeto JSON.
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'idDisciplina': idDisciplina,

    });

}

var professorController = ProfessorController();

class ProfessorController {
  List<Professor> getAll() {
    return pessoaController.getAll().whereType<Professor>().toList();
  }

  Professor save(professor) {
    return pessoaController.save(professor);
  }

  bool remove(professor) {
    return pessoaController.remove(professor);
  }
}

class ListProfessorPage extends StatefulWidget {
  @override
  ListProfessorPageState createState() => ListProfessorPageState();
}

class ListProfessorPageState extends State<ListProfessorPage> {
  List<Professor> _professor = professorController.getAll();

  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      title: 'Professores',
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => dsiHelper.go(context, '/maintain_professor'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: _professor.length,
        itemBuilder: _buildListTileProfessor,
      ),
    );
  }

  Widget _buildListTileProfessor(context, index) {
    var professor = _professor[index];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          professorController.remove(professor);
          _professor.remove(index);
        });
        dsiHelper.showMessage(
          context: context,
          message: '${professor.nome} foi removido.',
        );
      },
      background: Container(
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white),
            Spacer(),
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
      child: ListTile(
        title: Text(professor.nome),
        subtitle: Column(
          children: <Widget>[
            Text('id. ${professor.id} (JA APRENDEMOS QUE NAO SE DEVE EXIBIR O ID DE UM REGISTRO!)'),
            Text('disciplina:. ${professor.idDisciplina}'),
            Text('idLattes:. ${professor.idLattes}'),
          ],
        ),
        onTap: () => dsiHelper.go(context, "/maintain_professor", arguments: professor),
      ),
    );
  }
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);
    if (professor == null) {
      professor = Professor();
    }

    return DsiBasicFormPage(
      title: 'Professor',
      onSave: () {
        professorController.save(professor);
        dsiHelper.go(context, '/list_professor');
      },
      body: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CPF*'),
            validator: (String value) {
              return value.isEmpty ? 'CPF inválido.' : null;
            },
            initialValue: professor.cpf,
            onSaved: (newValue) => professor.cpf = newValue,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Nome*'),
            validator: (String value) {
              return value.isEmpty ? 'Nome inválido.' : null;
            },
            initialValue: professor.nome,
            onSaved: (newValue) => professor.nome = newValue,
          ),
          /*TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Endereço*'),
            validator: (String value) {
              return value.isEmpty ? 'Endereço inválido.' : null;
            },
            initialValue: professor.endereco,
            onSaved: (newValue) => professor.endereco = newValue,
          ),*/
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Disciplina*'),
            validator: (String value) {
              return value.isEmpty ? 'É necessário adicionar uma disciplina.' : null;
            },
            initialValue: professor.idDisciplina,
            onSaved: (newValue) => professor.idDisciplina = newValue,
              ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'ID no Lattes*'),
            validator: (String value) {
              return value.isEmpty ? 'É necessário adicionar um id.' : null;
            },
            initialValue: professor.idLattes,
            onSaved: (newValue) => professor.idLattes = newValue,
          ),
        ],
      ),
    );
  }
}
