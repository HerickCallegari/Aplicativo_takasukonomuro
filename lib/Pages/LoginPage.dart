import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takasukonomuro/Pages/GerentePage.dart';
import 'package:takasukonomuro/Pages/MesasPage.dart';
import 'package:takasukonomuro/models/Cargo.dart';
import 'package:takasukonomuro/models/Funcionario.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String login = '';
  String senha = '';
  String? errorMessage;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                top: 40,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  height: height * 0.67,
                  width: width * 0.72,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
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
                            'por favor, insira Login e senha',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'PlayFairDisplay'),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PlayFairDisplay'),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            onChanged: (value) => login = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira o Login';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontFamily: 'Roboto', fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Ex: 2537',
                              hintStyle: const TextStyle(fontFamily: 'Roboto'),
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
                          TextFormField(
                            onChanged: (value) => senha = value,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a senha';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontFamily: 'Roboto', fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Ex: 000000000',
                              hintStyle: const TextStyle(fontFamily: 'Roboto'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (errorMessage != null)
                            Text(
                              errorMessage!,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontFamily: 'Roboto'),
                            ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Funcionario? funcionario =
                                    funcionarios.firstWhere(
                                        (Funcionario func) =>
                                            (await Supabase.instance.client.from('Funcionarios').select('Senha')) as String == nome,
                                        orElse: null);

                                if (funcionario == null) {
                                  setState(() {
                                    errorMessage = "Funcionário não encontrado";
                                  });
                                  return;
                                }

                                if (funcionario.senha != senha) {
                                  setState(() {
                                    errorMessage = "Senha incorreta";
                                  });
                                  return;
                                }

                                setState(() {
                                  errorMessage = null;
                                });

                                if (funcionario.cargo == Cargo.Gerente) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GerentePage()));
                                } else if (funcionario.cargo == Cargo.Garcom) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MesasPage()));
                                }
                              }
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
              ),
            ],
          );
        },
      ),
    );
  }
}
