

import 'package:agenda/entidade/contato.dart';

class PessoaController {
  final InterfaceDao _dao = DaoSqLite() as InterfaceDao;
  List lista = [];
  salvar(Pessoa c) {
    _dao.add(c);
  }
  remover(Pessoa c) {
    _dao.remove(c);
  }
  Future<List<Pessoa>> listar() {
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
  Future<Pessoa> get(int indice) async {
    lista = await _dao.dados;
    return lista[indice];
  }
}