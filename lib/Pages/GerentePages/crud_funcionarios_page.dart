import 'package:flutter/material.dart';
import 'package:takasukonomuro/Pages/GerentePages/formulario_funcionario_page.dart'; // Importando a página do formulário

class CrudFuncionariosPage extends StatefulWidget {
  @override
  _CrudFuncionariosPageState createState() => _CrudFuncionariosPageState();
}

class _CrudFuncionariosPageState extends State<CrudFuncionariosPage> {
  // Lista fictícia de funcionários
  final List<Map<String, String>> funcionarios = [
    {'name': 'Marcos Felipe Souza', 'role': 'Garçom'},
    {'name': 'André Mioto', 'role': 'Cozinheiro'},
    {'name': 'Vanessa Lima', 'role': 'Garçom'},
    {'name': 'Cláudio Silva', 'role': 'Zelador'},
    {'name': 'Maria Ferreira', 'role': 'Zelador'},
    {'name': 'Leila Pereira', 'role': 'Garçom'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Cor de fundo
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          color: Colors.white, // Cor de fundo da AppBar
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Funcionários',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: funcionarios.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(Icons.person, size: 40),
                      title: Text(funcionarios[index]['name']!),
                      subtitle: Text(funcionarios[index]['role']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              // Lógica para editar o funcionário
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Lógica para deletar o funcionário
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Botão Adicionar Funcionário alinhado à direita
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Redireciona para a página de cadastro de funcionário
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormularioFuncionarioPage()), // Página de cadastro
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white), // Símbolo "+"
                    SizedBox(width: 8), // Espaçamento entre o ícone e o texto
                    Text(
                      'Adicionar Funcionário',
                      style: TextStyle(color: Colors.white), // Texto em branco
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Cor de fundo do botão
                  foregroundColor: Colors.white, // Cor do texto
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: BorderSide(color: Colors.black), // Borda preta
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
