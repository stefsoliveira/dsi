import 'package:dsi_app/constants.dart';
import 'package:dsi_app/infra.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsi_app/home.dart';

class RegisterPersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      body: Column(
        children: <Widget>[
          Constants.spaceMediumHeight,
          Constants.spaceMediumHeight,
          Text('Cadastro de pessoa',
                style: TextStyle(fontSize: 24),
          ),
          Constants.spaceMediumHeight,
          RegisterPersonForm(),
          Spacer(),
        ],
      ),
      appBar: _buildAppBar(context),
    );
  }
  Widget _buildAppBar(context) {
    return AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {
          dsiHelper.go(context, HomePage());
        },),
        title: Text('Home'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
            padding: EdgeInsets.symmetric(horizontal: 16),
            onPressed: ()  {
              dsiHelper.go(context, RegisterPersonPage());
            },),
          Icon(Icons.more_vert),
        ]
    );
  }
}

class RegisterPersonForm extends StatefulWidget {
  @override
  RegisterPersonFormState createState() {
    return RegisterPersonFormState();
  }
}

class RegisterPersonFormState extends State<RegisterPersonForm> {
  final _formKey = GlobalKey<FormState>();

  void _register() {
    if (!_formKey.currentState.validate()) return;

    dsiDialog.showInfo(
      context: context,
      message: 'Seu cadastro foi realizado com sucesso.',
      buttonPressed: () => dsiHelper..back(context)..back(context),
    );

    //A linha acima é equivalente a executar as duas linhas abaixo:
    //Navigator.of(context).pop();
    //Navigator.of(context).pop();
    //
    //Para maiores informações, leia sobre 'cascade notation' no Dart.
    //https://dart.dev/guides/language/language-tour
  }

  void _cancel() {
    dsiHelper.back(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: Constants.paddingMedium,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Nome Completo*'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo é obrigatório.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Sobrenome*'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo é obrigatório.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Telefone*'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo é obrigatório.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration:
              const InputDecoration(labelText: 'Email de cadastro*'),
              validator: (String value) {
                return value.isEmpty
                    ? 'Este campo é obrigatório.'
                    : null;
              },
            ),
            Constants.spaceMediumHeight,
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Salvar'),
                onPressed: _register,
              ),
            ),
            FlatButton(
              child: Text('Cancelar'),
              padding: Constants.paddingSmall,
              onPressed: _cancel,
            ),
          ],
        ),
      ),
    );
  }
}
