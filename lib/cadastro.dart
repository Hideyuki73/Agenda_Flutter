// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:agenda/controller/contatoController.dart';
import 'package:agenda/entidade/contato.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Cadastro extends StatelessWidget {
  final ContatoController contatoController;

  const Cadastro(
      {super.key,
      required this.contatoController}); // Recebe o controlador como argumento
// Função para validar o email
  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    );
    return emailRegex.hasMatch(email);
  }

  // Função para validar o telefone
  bool _isTelefoneValid(String phone) {
    final RegExp phoneRegex = RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$');
    return phoneRegex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    MaskedTextController telefoneController =
        MaskedTextController(mask: '(00) 00000-0000');
    return Scaffold(
        body: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(hintText: 'Nome'),
                    controller: nomeController),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '(XX)XXXXX XXXX'),
                    controller: telefoneController),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    controller: emailController),
                FilledButton(
                    onPressed: () {
                      // Validação do e-mail
                      if (!_isEmailValid(emailController.text)) {
                        // Exibe um alerta se o email for inválido
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Por favor, insira um e-mail válido.')),
                        );
                        return; // Sai da função se o e-mail não for válido
                      }
                      if (!_isTelefoneValid(telefoneController.text)) {
                        // Exibe um alerta se o telefone for inválido
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Por favor, insira um telefone válido.')),
                        );
                        return; // Sai da função se o e-mail não for válido
                      }

                      // Criação da nova Contato
                      Contato novaContato = Contato(
                        nome: nomeController.text,
                        email: emailController.text,
                        telefone: telefoneController.text,
                      );

                      // Adiciona a nova Contato ao controlador
                      contatoController.salvar(novaContato);

                      Navigator.pop(context);
                    },
                    child: const Text('Salvar'))
              ],
            ));
  }
}
