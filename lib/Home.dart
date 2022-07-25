import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "";
  TextEditingController _textEditingController = TextEditingController();

  _recuperarCep() async {
    String cep = _textEditingController.text;
    var url = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = jsonDecode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "$logradouro, $bairro, $localidade";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Utilizando API web"),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(_resultado,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite o CEP",
              ),
              maxLength: 8,
              controller: _textEditingController,
            ),
            ElevatedButton(onPressed: _recuperarCep, child: const Text("Clique aqui")),
          ],
        ),
      ),
    );
  }
}
