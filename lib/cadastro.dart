// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:agenda/contato.dart';
import 'package:agenda/listagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Cadastro extends StatefulWidget {
  final ContatosRepository contatos;
  final Contato? contato;
  final int? index;
  const Cadastro({super.key, required this.contatos, this.contato, this.index});

  @override
  State<Cadastro> createState() => _CadastroState(contatos: contatos);
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController =
      MaskedTextController(mask: '(00)00000 0000');//define o formato do numero
  TextEditingController emailController = TextEditingController();
  final ContatosRepository contatos;
  final _formKey = GlobalKey<FormState>(); 

  _CadastroState({required this.contatos});

  @override
  void initState() {
    super.initState();
    if (widget.contato != null) {
      nomeController = TextEditingController(text: widget.contato!.nome);
      emailController = TextEditingController(text: widget.contato!.email);
      telefoneController =
          TextEditingController(text: widget.contato!.telefone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [//Define os campos de entrada de dados no cadastro
                TextFormField(
                    decoration: InputDecoration(hintText: 'Nome'),
                    controller: nomeController,
                    validator: (nomeController) {
                      if (nomeController == null || nomeController.isEmpty) {
                        return 'Nome obrigatorio';
                      }
                      return null;
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '(XX)XXXXX XXXX'),
                    controller: telefoneController,
                    validator: (telefoneController) {
                      if (telefoneController == null ||
                          telefoneController.isEmpty || telefoneController.length == 11) {
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
                      if (RegExp(r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$')//verifica se o email é válido
                          .hasMatch(emailController)) {
                        return null;
                      }
                      return 'Email invalido';
                    }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            if(widget.contato != null){//verifica se vai editar ou cadastrar, se for editar vai pegar o que tava salvo
                              Navigator.pop(context,
                                Contato(
                                nome: nomeController.text,
                                email: emailController.text,
                                telefone: telefoneController.text)
                              );
                            }else{
                              contatos.addContatos(Contato(
                                nome: nomeController.text,
                                email: emailController.text,
                                telefone: telefoneController.text));  
                                Navigator.pop(context);
                            }
                          });
                        }
                      },
                      child: Text('Salvar'),
                    ),
                    
                  ],
                )
              ],
            ),
          )),
    );
  }
}
