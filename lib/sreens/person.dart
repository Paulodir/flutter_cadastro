import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cadastro/sreens/cadastrar.dart';
import 'package:flutter_cadastro/sreens/home.dart';
import 'package:flutter_cadastro/helper/person_helper.dart';

class PersonPage extends StatefulWidget {
  final Person person;
  PersonPage({this.person});
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nomeFocus = FocusNode();

  Person _editedPerson;
  bool _userEdited = false;

  @override
  void initState() {
    super.initState();
    if (widget.person == null) {
      _editedPerson = Person();
    } else {
      _editedPerson = Person.fromMap(widget.person.toMap());
      _nomeController.text = _editedPerson.nome;
      _telefoneController.text = _editedPerson.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(_editedPerson.nome ?? 'Novo contato'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.save),
              backgroundColor: Colors.red,
              onPressed: () {
                if (_editedPerson.nome != null && _editedPerson.nome.isNotEmpty) {
                  Navigator.pop(context, _editedPerson);
                } else {
                  FocusScope.of(context).requestFocus(_nomeFocus);
                }
              }),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Nome"),
                  focusNode: _nomeFocus,
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedPerson.nome = text;
                    });
                  },
                  controller: _nomeController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Telefone"),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedPerson.telefone = text;
                  },
                  keyboardType: TextInputType.phone,
                  controller: _telefoneController,
                ),
              ],
            ),
          ),
        ));
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar alterações?'),
              content: Text('Se sair as alterações serão perdidas.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}