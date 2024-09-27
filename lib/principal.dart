// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:agenda/cadastro.dart';
import 'package:agenda/contato.dart';
import 'package:agenda/listagem.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Principal(),
      theme: ThemeData.from(//define o tema da aplicação
        colorScheme: ColorScheme.fromSwatch(
            cardColor: Colors.grey.shade900,
            backgroundColor: Colors.white,
            accentColor: Colors.white,
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple),
      )
    );
  }
}

class Principal extends StatelessWidget {
  final ContatosRepository contatos = ContatosRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [//botões para enviar para a tela de listagem e cadastro
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cadastro(contatos: contatos),
                    ),
                  );
                },
                child: Text("Cadastro"),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Listagem(contatos: contatos),
                    ),
                  );
                },
                child: Text("Listar"),
              ),
            ],
          ),
        ));
  }
}