import 'package:flutter/material.dart';

class GerentePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GerentePage();
}

class _GerentePage extends State<GerentePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(
                context); // Chama Navigator.pop quando o botão é pressionado
          },
          child: const Text("Voltar"),
        ),
      ),
    );
  }
}
