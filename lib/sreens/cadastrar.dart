import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../helper/person_helper.dart';

class Cadastrar extends StatefulWidget {
  final Person person;
  Cadastrar({this.person});
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedPerson.nome ?? "Cadastro"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Digite o Nome'),
                    focusNode: _nomeFocus,
                    onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedPerson.nome = text;
                      });
                    },
                    controller: _nomeController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Digite o Telefone'),
                    onChanged: (text) {
                      _userEdited = true;
                      _editedPerson.telefone = text;
                    },
                    controller: _telefoneController,
                  ),
                  RaisedButton(
                      onPressed: (){

                        //print(_nomeController.toString()+_telefoneController.toString());
                        if (_editedPerson.nome != null &&
                            _editedPerson.nome.isNotEmpty) {
                          Navigator.pop(context, _editedPerson);
                        } else {
                          FocusScope.of(context).requestFocus(_nomeFocus);
                        }
                      },
                    color: Colors.blueAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.save, color: Colors.white),
                      ],
                    ),
                      ),
                ],
              ),

      ),

    );
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
