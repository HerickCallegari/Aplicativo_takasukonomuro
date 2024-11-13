import 'dart:ui'; // Import necessário para usar BackdropFilter
import 'package:flutter/material.dart';
import 'package:takasukonomuro/pages/LoginPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Stack(
            children: [
              // Imagem de fundo
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/yaki.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Gradiente que vai do transparente ao preto, de cima para baixo
              Positioned(
                left: 0,
                right: 0,
                top: height * 0.5,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                      ],
                      stops: [0.0, 0.4, 1.0], // Define os pontos de transição
                    ),
                  ),
                ),
              ),

              // Texto com blur aplicado nas letras
              Positioned(
                left: width * 0.05,
                top: height * 0.64,
                child: Stack(
                  children: [
                    // Texto desfocado de fundo
                    Text(
                      'Takasukonomuro',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'PlayFairDisplay',
                        foreground: Paint()
                          ..color = Colors.transparent
                          ..imageFilter =
                              ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      ),
                    ),
                    // Texto nítido por cima do desfocado
                    const Text(
                      'Takasukonomuro',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'PlayFairDisplay',
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Segundo texto (nítido) com gradiente de fundo
              Positioned(
                left: width * 0.05,
                top: height * 0.72,
                child: const Text(
                  'The best Japanese food of Xique-Xique BA',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'PlayFairDisplay',
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Botão com seta no final
              Positioned(
                left: width * 0.0953125,
                top: height * 0.86,
                width: width * 0.85,
                height: height * 0.1,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    backgroundColor: Colors.white, // Cor de fundo do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Arredondamento das bordas
                    ),
                  ),
                  child: const Row(
                    children: [
                      // Texto centralizado
                      Expanded(
                        child: Center(
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              //fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      // Espaço entre o texto e a seta
                      Icon(
                        Icons.arrow_forward, // Ícone de seta
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
