import 'package:agenda/listagem.dart';

class ContatosRepository {
  final List<Contato> contatos = [];

  void addContatos(Contato contato) {
    contatos.add(contato);
  }

  void rmvContatos(Contato contato){
    contatos.remove(contato);
  }

  void updateContatos(int index, Contato contato){
    contatos[index] = contato;
  }

  List<Contato> getContatos() {
    return contatos;
  }
}