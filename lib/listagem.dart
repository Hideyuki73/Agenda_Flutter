// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:agenda/cadastro.dart';
import 'package:agenda/contato.dart';
import 'package:flutter/material.dart';

class Contato {
  final String nome;
  final String telefone;
  final String email;
  Contato({required this.nome, required this.telefone, required this.email});
}

class Listagem extends StatefulWidget {
  final ContatosRepository contatos;
  Listagem({required this.contatos});

  @override
  // ignore: no_logic_in_create_state
  State<Listagem> createState() => ListagemState(contatos: contatos);
}

class ListagemState extends State<Listagem> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ContatosRepository contatos;

  ListagemState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.getContatos().length,
        itemBuilder: (context, index) {
          Contato c = contatos.getContatos()[index];
          return ListTile(
            title: Text(
              c.nome,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.email),
                Text(c.telefone),
              ],
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              FilledButton(
                  onPressed: () {
                    setState(() {
                      contatos.rmvContatos(c);
                    });
                  },
                  child: Text('Deletar')),
              SizedBox(width: 10),
              FilledButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro(contatos: contatos, contato: c, index: index,))).then((contato) => setState(() {
                  contatos.updateContatos(index, contato);
                }));
              }, 
              child: Text('Editar'))
            ]),
          );
        },
      ),
    );
  }
}