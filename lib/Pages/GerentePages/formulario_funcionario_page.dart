import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/funcionarioService.dart'; // Importando o serviço
import 'package:takasukonomuro/models/funcionario.dart'; // Caminho para o modelo Funcionario
import 'package:takasukonomuro/models/enums/cargo.dart'; // Importando o enum para Cargo

class FormularioFuncionarioPage extends StatefulWidget {
  @override
  _FormularioFuncionarioPageState createState() =>
      _FormularioFuncionarioPageState();
}

class _FormularioFuncionarioPageState extends State<FormularioFuncionarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cargoController = TextEditingController();
  
  final FuncionarioService funcionarioService = FuncionarioService();

  List<String> cargos = ['Garçom', 'Gerente']; // Lista de cargos atualizada
  String selectedCargo = 'Garçom'; // Cargo selecionado inicialmente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Cor de fundo suave
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Ajuste da altura para o conteúdo caber
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Voltar para a tela anterior
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
                    ),
                    child: Text(
                      'Cadastro de Funcionário',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis, // Garante que o texto não ultrapasse o limite
                      maxLines: 1,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {},
                  padding: EdgeInsets.zero, // Para reduzir o espaço do ícone
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 340, // Largura do fundo branco ajustada
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Login
                    TextFormField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        labelText: 'Login*',
                        hintText: 'Digite o Login do funcionário',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o Login do funcionário.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Nome Completo
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome Completo*',
                        hintText: 'Ex: Matheus Martins Lordron',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome completo do funcionário.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // CPF
                    TextFormField(
                      controller: _cpfController,
                      decoration: InputDecoration(
                        labelText: 'CPF*',
                        hintText: 'Ex: 000.000.000-00',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF do funcionário.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Senha
                    TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        labelText: 'Senha*',
                        hintText: 'Insira a senha do funcionário',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a senha do funcionário.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Cargo
                    DropdownButtonFormField<String>(
                      value: selectedCargo,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCargo = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Cargo*',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      items: cargos.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione o cargo.';
                        }
                        return null;
                      },
                    ),
                    Spacer(), // Esse espaço puxa os botões para baixo

                    // Botões de Salvar e Cancelar
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0), // Adicionando um padding extra
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Voltar para a tela anterior
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Cria um novo funcionário
                                final funcionario = Funcionario(
                                  login: null, // Login gerado automaticamente no banco
                                  nome: _nomeController.text,
                                  cpf: _cpfController.text,
                                  senha: _senhaController.text,
                                  cargo: _getCargo(selectedCargo), // Converte para o enum
                                );

                                try {
                                  // Comente a linha abaixo para testar o front-end sem o Supabase
                                  // await funcionarioService.add(funcionario);
                                  print('Funcionário salvo localmente: ${funcionario.nome}, ${funcionario.cpf}, ${funcionario.cargo}');

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Funcionário salvo com sucesso!")),
                                  );
                                  Navigator.pop(context); // Volta para a tela anterior
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Erro ao salvar funcionário: $e")),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Salvar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Cargo _getCargo(String cargo) {
    switch (cargo) {
      case 'Garçom':
        return Cargo.Garcom;
      case 'Gerente':
        return Cargo.Gerente;
      default:
        throw Exception("Cargo não reconhecido");
    }
  }
}
