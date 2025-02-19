import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/funcionarioService.dart';
import 'package:takasukonomuro/models/funcionario.dart';
import 'package:takasukonomuro/Pages/GerentePages/formulario_funcionario_page.dart';

class CrudFuncionariosPage extends StatefulWidget {
  @override
  _CrudFuncionariosPageState createState() => _CrudFuncionariosPageState();
}

class _CrudFuncionariosPageState extends State<CrudFuncionariosPage> {
  // Lista que será carregada dinamicamente com os dados do banco
  late Future<List<Funcionario>> funcionarios;

  @override
  void initState() {
    super.initState();
    funcionarios = FuncionarioService().findAll(); // Carregar lista de funcionários do banco
  }

  // Função para excluir o funcionário
  void _deleteFuncionario(Funcionario funcionario) async {
    try {
      await FuncionarioService().remove(funcionario);  // Chama a função de remover
      setState(() {
        funcionarios = FuncionarioService().findAll();  // Atualiza a lista após a exclusão
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir funcionário.')),
      );
    }
  }

  // Função para atualizar a lista de funcionários
  void _refreshList() {
    setState(() {
      funcionarios = FuncionarioService().findAll();  // Recarrega a lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparente para exibir o background
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
                  icon: Icon(Icons.refresh), // Ícone do botão de refresh
                  onPressed: _refreshList, // Chama a função de atualizar a lista
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
                image: AssetImage('assets/images/funcionariosFundo.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<Funcionario>>(
                      future: funcionarios, // Chama a função de buscar funcionários
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro ao carregar funcionários.'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('Nenhum funcionário encontrado.'));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Funcionario funcionario = snapshot.data![index];
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  leading: Icon(Icons.person, size: 40),
                                  title: Text(funcionario.nome),
                                  subtitle: Text(funcionario.getCargo().toString().split('.').last),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.black),
                                        onPressed: () {
                                          // Navegar para a página de edição, passando os dados do funcionário
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => FormularioFuncionarioPage(funcionario: funcionario)),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          // Chama a função de deletar
                                          _deleteFuncionario(funcionario);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(

            bottom: MediaQuery.of(context).size.height * 0.21, // Ajustado para afastar mais do logo
            left: MediaQuery.of(context).size.width * 0.5 - 100, // Centraliza o botão
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormularioFuncionarioPage()),
                );
              },
              label: Text(
                'Adicionar Funcionário',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
