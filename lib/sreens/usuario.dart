import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cadastro/helper/usuario_helper.dart';

class CadastrarUsuario extends StatefulWidget {

  final Usuario usuario;
  CadastrarUsuario({this.usuario});

  @override
  _CadastrarUsuarioState createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _emailFocus = FocusNode();

  Usuario _editedUsuario;
  bool logado = false;

  @override
  void initState() {
    super.initState();
    if (widget.usuario == null) {
      _editedUsuario = Usuario();
    } else {
      _editedUsuario = Usuario.fromMap(widget.usuario.toMap());
      _emailController.text = _editedUsuario.email;
      _senhaController.text = _editedUsuario.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedUsuario.email ?? "Cadastro"),
        //automaticallyImplyLeading: false,//retira a opção de voltar
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Cadastre o e-mail de Usuário',
              ),
              focusNode: _emailFocus,
              onChanged: (text) {
                logado = true;
                setState(() {
                  _editedUsuario.email = text;
                });
              },
              controller: _emailController,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              //obscureText: true,
              decoration: InputDecoration(
                labelText: 'Cadastre Uma Senha',
              ),
            //  onChanged: (text) {
             //   _userEdited = true;
             //   _editedUsuario.senha = text;
            //  },
              controller: _senhaController,
            ),
            RaisedButton(
              onPressed: () {
                //print(_emailController.toString()+_senhaController.toString());
                if (_editedUsuario.email != null &&
                    _editedUsuario.email.isNotEmpty) {
                  Navigator.pop(context, _editedUsuario);
                } else {
                  FocusScope.of(context).requestFocus(_emailFocus);
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
    if (logado) {
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
