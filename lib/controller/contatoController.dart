

import 'package:agenda/entidade/contato.dart';
import 'package:agenda/repositorio/DaoSqLite.dart';
import 'package:agenda/repositorio/interfaceDao';

class ContatoController {
  final InterfaceDao _dao = DaoSqLite();
  List lista = [];
  salvar(Contato p) {
    _dao.add(p);
  }

  remover(Contato p) {
    _dao.remove(p);
  }

  Future<List<Contato>> listar() {
    return _dao.dados;
  }

  Future<int> size() async {
    lista = await _dao.dados;
    return lista.length;
  }

  info(int indice) async {
    lista = await _dao.dados;
    return _dao.dados;
  }

  Future<Contato> get(int indice) async {
    lista = await _dao.dados;
    return lista[indice];
  }
}