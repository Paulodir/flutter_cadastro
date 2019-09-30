import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String usuarioTable = "usuarioTable";
final String idColumn = "id";
final String emailColumn = "email";
final String senhaColumn = "senha";
final String logadoTable = "logadoTable";
final String idLogado = "id";

class UsuarioHelper {
  static final UsuarioHelper _instance = UsuarioHelper.internal();
  factory UsuarioHelper() => _instance;
  UsuarioHelper.internal();
  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "sdsd.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $usuarioTable($idColumn INTEGER PRIMARY KEY, $emailColumn TEXT, $senhaColumn TEXT)"
      );
    });
  }

  Future<Usuario> saveUsuario(Usuario usuario) async {
    Database dbUsuario = await db;
    usuario.id = await dbUsuario.insert(usuarioTable, usuario.toMap());
    return usuario;
  }

  Future<Usuario> getUsuario(int id) async {
    Database dbUsuario = await db;
    List<Map> maps = await dbUsuario.query(usuarioTable,
        columns: [idColumn, emailColumn, senhaColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteUsuario(int id) async {
    Database dbUsuario = await db;
    return await dbUsuario.delete(usuarioTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateUsuario(Usuario usuario) async {
    Database dbUsuario = await db;
    return await dbUsuario.update(usuarioTable,
        usuario.toMap(),
        where: "$idColumn = ?",
        whereArgs: [usuario.id]);
  }

  Future<List> getAllUsuarios() async {
    Database dbUsuario = await db;
    List listMap = await dbUsuario.rawQuery("SELECT * FROM $usuarioTable");
    List<Usuario> listUsuario = List();
    for(Map m in listMap){
      listUsuario.add(Usuario.fromMap(m));
    }
    return listUsuario;
  }

  Future close() async {
    Database dbUsuario = await db;
    dbUsuario.close();
  }

}

class Usuario {

  int id;
  String email;
  String senha;

  Usuario();

  Usuario.fromMap(Map map){
    id = map[idColumn];
    email = map[emailColumn];
    senha = map[senhaColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      emailColumn: email,
      senhaColumn: senha
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Usuario(id: $id, nome: $email, senha: $senha)";
  }

}
