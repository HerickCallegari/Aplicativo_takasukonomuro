import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/funcionarioService.dart';
import 'package:takasukonomuro/models/funcionario.dart';
import 'package:takasukonomuro/models/enums/cargo.dart';

class FormularioFuncionarioPage extends StatefulWidget {
  final Funcionario? funcionario;  // Para edição de um funcionário existente

  FormularioFuncionarioPage({this.funcionario});

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
  String selectedCargo = 'Garçom';  // Valor padrão

  final FuncionarioService funcionarioService = FuncionarioService();

  List<String> cargos = ['Garçom', 'Gerente'];

  @override
  void initState() {
    super.initState();
    if (widget.funcionario != null) {
      // Se for edição, preencher os campos com os dados do funcionário
      _nomeController.text = widget.funcionario!.nome;
      _cpfController.text = widget.funcionario!.cpf;
      _senhaController.text = widget.funcionario!.senha;
      
      // Verificar se o cargo é válido na lista
      selectedCargo = widget.funcionario!.cargo.toString().split('.').last;

      // Garantir que o valor de selectedCargo seja um dos valores válidos
      if (!cargos.contains(selectedCargo)) {
        selectedCargo = cargos[0];  // Se não for válido, coloca um valor padrão
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                      widget.funcionario != null
                          ? 'Editar Funcionário'
                          : 'Cadastro de Funcionário',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fomularioFuncFundo.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(
                        _loginController, 'Login*', 'Digite o Login do funcionário'),
                    SizedBox(height: 20),
                    _buildTextField(_nomeController, 'Nome Completo*', 'Ex: Matheus Martins Lordron'),
                    SizedBox(height: 20),
                    _buildTextField(_cpfController, 'CPF*', 'Ex: 000.000.000-00'),
                    SizedBox(height: 20),
                    _buildTextField(_senhaController, 'Senha*', 'Insira a senha do funcionário', isPassword: true),
                    SizedBox(height: 20),
                    _buildDropdown(),
                    SizedBox(height: 20),
                    _buildButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
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
          return 'Por favor, preencha este campo.';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
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
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              final funcionario = Funcionario(
                login: widget.funcionario?.login,  // Para edição de um funcionário existente
                nome: _nomeController.text,
                cpf: _cpfController.text,
                senha: _senhaController.text,
                cargo: _getCargo(selectedCargo),
              );

              try {
                if (widget.funcionario != null) {
                  // Se for edição, chama o update
                  await FuncionarioService().update(funcionario);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Funcionário atualizado com sucesso!")));
                } else {
                  // Se for criação, chama o add
                  await FuncionarioService().add(funcionario);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Funcionário salvo com sucesso!")));
                }

                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao salvar funcionário: $e")));
              }
            }
          },
          child: Text('Salvar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
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
