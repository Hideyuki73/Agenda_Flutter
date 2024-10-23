// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors
import 'package:agenda/controller/contatoController.dart';
import 'package:flutter/material.dart';

class Listagem extends StatefulWidget {
  final ContatoController contatoController;

  const Listagem({super.key, required this.contatoController});

  @override
  State<StatefulWidget> createState() {
    return _Listagem();
  }
}

class _Listagem extends State<Listagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Pessoas'),
      ),
      body: FutureBuilder<List>(
        future: widget.contatoController
            .listar(), // Chama o método assíncrono para obter o tamanho
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Indicador de carregamento
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro: ${snapshot.error}')); // Mensagem de erro
          } else {
            // O número de itens
            final List itens = snapshot.data!;
            return ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, indice) {
                return ListTile(
                  title: Text(itens[indice].nome), // Exibe o nome da pessoa
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Confirmação antes de excluir
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirmar Exclusão'),
                            content: const Text(
                                'Você tem certeza que deseja excluir este item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Fecha o diálogo
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Remove o item
                                  await widget.contatoController
                                      .remover(itens[indice]);
                                  setState(
                                      () {}); // Atualiza a lista após excluir
                                  Navigator.of(context)
                                      .pop(); // Fecha o diálogo
                                },
                                child: const Text('Excluir'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro').then((_) {
            setState(() {}); // Atualiza a lista após voltar
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
