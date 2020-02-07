import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List _pautasList = [
    {
      "titulo": "Título",
      "autor": "Autor",
      "resumo": "Resumo",
      "texto":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
    },
  ];

  final _autorController = TextEditingController();
  final _tituloController = TextEditingController();
  final _resumoController = TextEditingController();
  final _textoController = TextEditingController();

  void _addPauta() {
    if ((_autorController.text.isEmpty) ||
        (_tituloController.text.isEmpty) ||
        (_resumoController.text.isEmpty) ||
        (_textoController.text.isEmpty)) {
      Toast.show(
        "\n  Preencha todos os campos  \n",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundRadius: 5.0,
      );
    } else {
      setState(() {
        Map<String, dynamic> newPauta = Map();
        newPauta["titulo"] = _tituloController.text.trimLeft();
        newPauta["autor"] = _autorController.text.trimLeft();
        newPauta["resumo"] = _resumoController.text.trimLeft();
        newPauta["texto"] = _textoController.text.trimLeft();
        _pautasList.add(newPauta);
        print(_pautasList);
        setState(() {
          Navigator.of(context).pop();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 200, 220, 220),
      appBar: AppBar(
        title: Text("Pautas"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _pautasList.length,
          itemBuilder: (context, index) {
            return ExpansionCard(
              trailing:
                  Icon(Icons.arrow_drop_down, color: Colors.green, size: 50),
              backgroundColor: Color.fromARGB(255, 4, 175, 190),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _pautasList[index]["titulo"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      _pautasList[index]["autor"],
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _pautasList[index]["resumo"],
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(_pautasList[index]["texto"],
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20, color: Colors.white70)),
                ),
                GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 310),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title:
                                    new Text("Deseja remover o item da lista?"),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Fechar"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                  new FlatButton(
                                      child: new Text("Excluir"),
                                      onPressed: () {
                                        _pautasList.removeAt(index);
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      })
                                ]);
                          });
                    }),
                SizedBox(height: 10),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: new Text("Adicionar Nova Pauta"),
                      content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Título'),
                                controller: _tituloController),
                            TextFormField(
                                decoration: InputDecoration(labelText: 'Autor'),
                                controller: _autorController),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Resumo'),
                                controller: _resumoController),
                            TextField(
                              decoration: InputDecoration(labelText: 'Texto'),
                              controller: _textoController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                            ),
                          ]),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Fechar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                            child: new Text("Adicionar"),
                            onPressed: () {
                              _addPauta();
                            })
                      ]); //
                });
          },
          tooltip: 'Adicionar',
          child: Icon(Icons.add, color: Colors.white)),
    );
  }
}
