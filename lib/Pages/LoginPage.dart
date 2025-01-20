import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/repositories/comandaRepository.dart';
import 'package:takasukonomuro/business/repositories/subComandaRepository.dart';
import 'package:takasukonomuro/business/repositories/transacaoRepository.dart';
import 'package:takasukonomuro/models/comanda.dart';
import 'package:takasukonomuro/models/enums/tipoTransacao.dart';
import 'package:takasukonomuro/models/subComanda.dart';
import 'package:takasukonomuro/models/transacao.dart';
import 'package:takasukonomuro/pages/gerentePage.dart';
import 'package:takasukonomuro/models/enums/cargo.dart';
import 'package:takasukonomuro/models/funcionario.dart';

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
                            keyboardType: TextInputType.number,
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                List<Funcionario> funcionarios = [
                                  Funcionario(
                                      login: 2,
                                      cpf: "1214815",
                                      nome: "kiria",
                                      senha: "123",
                                      cargo: Cargo.Gerente),
                                  Funcionario(
                                      login: 1,
                                      cpf: "61871125",
                                      nome: "herick",
                                      senha: "123",
                                      cargo: Cargo.Garcom),
                                  Funcionario(
                                      login: 3,
                                      cpf: "7147894",
                                      nome: "Matheus",
                                      senha: "123",
                                      cargo: Cargo.Garcom),
                                  Funcionario(
                                      login: 999,
                                      cpf: "teste",
                                      nome: "teste",
                                      senha: "123",
                                      cargo: Cargo.Garcom)
                                ];

                                // Convertendo o valor de `login` para int para comparar corretamente
                                int? loginInt = int.tryParse(login);
                                if (loginInt == null) {
                                  setState(() {
                                    errorMessage = "Login inválido";
                                  });
                                  return;
                                }

                                /*
                                // caso queira mostrar a API
                                FuncionarioRepository repository =
                                    FuncionarioRepository();
                                Funcionario? funcionario =
                                    await repository.findBy(login);
                                */

                                // Para evitar usar a API e gastar tokens
                                Funcionario? funcionario = funcionarios
                                    .firstWhere((f) => f.login == loginInt,
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
                                } else if (funcionario.login == 999) {
                                  // Bloco de teste de codigo
                                  ComandaRepository comandaRepository =
                                      ComandaRepository();
                                  SubComandaRepository subComandaRepository =
                                      SubComandaRepository();
                                  Comanda comanda = Comanda(
                                      mesaId: 1,
                                      funcionarioId: 1,
                                      data: DateTime.now(),
                                      horarioAbertura: DateTime.now(),
                                      valorTotal: 0,
                                      pago: false);
                                  comandaRepository.add(comanda);
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
