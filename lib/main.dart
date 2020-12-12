import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Final());

class Final extends StatelessWidget {
  const Final({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FinalApp - Hurtado",
      debugShowCheckedModeBanner: false,
      home: FinalApp()
    );
  }
}

class FinalApp extends StatefulWidget {
  FinalApp({Key key}) : super(key: key);

  @override
  _FinalAppState createState() => _FinalAppState();
}

class _FinalAppState extends State<FinalApp> {

  TextEditingController numeroController = TextEditingController();
  TextEditingController mensajeController = TextEditingController();

  Future <void> operaciones (String numero) async {
    var response = await http.get(
      "https://webservicehurtado.azurewebsites.net/api/Operaciones/" + numero,
      headers: {
        "Accept":"application/json"
      }
    );

    var data = json.decode(response.body);
    print(data["Mensaje"]);
    mensajeController.text = data["Mensaje"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FINAL - HURTADO"),   
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: numeroController,
            decoration: InputDecoration(
              hintText: "Ingrese un número"
            )
          ),
          RaisedButton(
            child: Text("API"),
            onPressed: () {
              operaciones(numeroController.text);
            }
          ),
          TextFormField(
            controller: mensajeController,
          ),
          Image.network(mensajeController.text)
        ],
      ),
    );
  }
}
