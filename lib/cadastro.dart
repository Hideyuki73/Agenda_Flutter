// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:agenda/contato.dart';
import 'package:agenda/listagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Cadastro extends StatefulWidget {
  final ContatosRepository contatos;
  const Cadastro({super.key, required this.contatos});

  @override
  State<Cadastro> createState() => _CadastroState(contatos: contatos);
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = MaskedTextController(mask: '(00)00000 0000');
  final TextEditingController emailController = TextEditingController();
  final ContatosRepository contatos;

  _CadastroState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome'
                  ),
                controller: nomeController,
                validator: (nomeController) {
                  if (nomeController == null || nomeController.isEmpty) {
                    return 'Nome obrigatorio';
                  }
                  return null;
                }),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Telefone'),
                controller: telefoneController,
                validator: (telefoneController) {
                  if (telefoneController == null || telefoneController.isEmpty) {
                    return 'Telefone obrigatorio';
                  }
                  return null;
                }),
            TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                controller: emailController,
                validator: (emailController) {
                  if (emailController == null || emailController.isEmpty) {
                    return 'Email obrigatorio';
                  }
                  return null;
                }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
              onPressed: () {
                setState(() {
                  contatos.addContatos(Contato(
                      nome: nomeController.text,
                      email: telefoneController.text,
                      telefone: emailController.text));
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            ElevatedButton(onPressed: () {Navigator.pop(context);},
              child: Text('Cancelar'),
            ),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}