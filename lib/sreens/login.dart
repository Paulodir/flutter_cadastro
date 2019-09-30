import 'package:flutter/material.dart';
import 'package:flutter_cadastro/helper/usuario_helper.dart';
import 'package:flutter_cadastro/sreens/usuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UsuarioHelper helper = UsuarioHelper();
  List<Usuario> usuarios = List();
  String _infoText = "";
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void logar() {
    setState(() {
      _infoText = "Logando...";
    });
  }
  void _showPersonPage({Usuario usuario}) async {
    //print(person.nome.toString());
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
        print(recUsuario.toString());
      }
      print(helper.getAllUsuarios().then.toString());
      _getAllUsuarios();
    }
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

  /*void resetFilds(){
    weightController.text="";
    heightController.text="";
    setState(() {
      _infoText = "";
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login de Usuário"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Digite seu e-mail",
                  labelStyle: TextStyle(color: Colors.blueAccent),
                ),
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencha o e-mail";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Digite sua senha",
                  labelStyle: TextStyle(color: Colors.blueAccent),
                ),
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencha a senha";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        logar();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
                    },
                    color: Colors.blueAccent,
                    child: Text(
                      "Logar",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CadastrarUsuario()),
                          );
                        },
                        color: Colors.blueAccent,
                        child: Text(
                          "Registrar",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
