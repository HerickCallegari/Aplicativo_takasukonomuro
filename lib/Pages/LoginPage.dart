import 'package:flutter/material.dart';
import 'package:takasukonomuro/Pages/GerentePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Impede que o layout seja redimensionado
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/fundo_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40, // Posiciona a seta um pouco abaixo do topo
                left: 20, // Posiciona a seta um pouco à direita da borda
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Volta para a tela anterior
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black, // Cor da seta
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius:
                        BorderRadius.circular(20), // Arredonda as bordas
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10, // Suaviza o contorno da sombra
                        offset: Offset(0, 4), // Posição da sombra
                      ),
                    ],
                  ),
                  height: height * 0.67,
                  width: width * 0.72,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'login',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PlayFairDisplay'),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'por favor, insira nome e senha',
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'PlayFairDisplay'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Nome',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayFairDisplay'),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16), // Fonte Roboto
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Ex: Herick Campos Calligari',
                            hintStyle: const TextStyle(
                                fontFamily: 'Roboto'), // Fonte Roboto no hint
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Senha',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayFairDisplay'),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          obscureText: true, // Oculta a senha
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16), // Fonte Roboto
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Ex: 000000000',
                            hintStyle: const TextStyle(
                                fontFamily: 'Roboto'), // Fonte Roboto no hint
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Cargo',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayFairDisplay'),
                        ),
                        const SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Ex: Gerente',
                            hintStyle: const TextStyle(
                                fontFamily: 'Roboto'), // Fonte Roboto no hint
                          ),
                          style: const TextStyle(
                              fontFamily: 'Roboto'), // Fonte Roboto no dropdown
                          items: const [
                            DropdownMenuItem(
                                value: 'Gerente', child: Text('Gerente')),
                            DropdownMenuItem(
                                value: 'Funcionário',
                                child: Text('Funcionário')),
                          ],
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GerentePage()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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
