import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cadastro/sreens/cadastrar.dart';
import 'package:flutter_cadastro/sreens/usuario.dart';
import 'package:flutter_cadastro/helper/usuario_helper.dart';
import 'package:url_launcher/url_launcher.dart' as _launchURL;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UsuarioHelper helper = UsuarioHelper();
  List<Usuario> usuarios = List();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("contatos"),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
          itemBuilder: (context, index) {
            return _itemList(context, index);
          }
       // children: <Widget>[
       //   _itemList(context, index),
       // ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showUsuarioPage();
          },
        child: Icon(Icons.add),
          ),
    );
  }


  Widget _itemList(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        usuarios[index].email ?? "",
                        style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(usuarios[index].senha ?? "",
                          style: TextStyle(fontSize: 13.0)),
                    ],
                  ),
                )
              ],
            ),
          )),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _getAllUsuarios();
  }
  void _getAllUsuarios() {
    helper.getAllUsuarios().then((list) {
      setState(() {
        usuarios = list;
      });
    });
  }

  void _showOptions(BuildContext context, int index)  {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person, color: Colors.red),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Ver',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20.0),
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showUsuarioPage(usuario: usuarios[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone, color: Colors.red),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Ligar',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          _launchURL.launch("tel:${usuarios[index].senha}");
                         Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
  void _showUsuarioPage({Usuario usuario}) async {
    //print("quandoquandoquandoquandoquandoquandoquandoquandoquandoquando"+usuario.email.toString());
    final recUsuario = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastrarUsuario(
              usuario: usuario,
            ),
        ));

    if (recUsuario != null) {
      if (usuario != null) {
        await helper.updateUsuario(recUsuario);
      } else {
        await helper.saveUsuario(recUsuario);
        print("quandoquandoquandoquandoquandoquandoquandoquandoquandoquando"+recUsuario.toString());
      }
      _getAllUsuarios();
    }
  }

}
