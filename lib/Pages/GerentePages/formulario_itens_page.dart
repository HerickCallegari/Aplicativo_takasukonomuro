import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/itemService.dart'; // Importando o serviço
import 'package:takasukonomuro/models/item.dart'; // Caminho para o modelo Item

class FormularioItensPage extends StatefulWidget {
  @override
  _FormularioItensPageState createState() => _FormularioItensPageState();
}

class _FormularioItensPageState extends State<FormularioItensPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _categoriaController = TextEditingController();

  final Itemservice itemService = Itemservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Cor de fundo suave
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
                    boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
                  ),
                  child: Text(
                    'Cadastro de Produto',
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
        child: Center(
          child: Container(
            width: 340, // Largura do fundo branco
            height: 444, // Altura do fundo branco
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15), // Fundo branco arredondado
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Descrição
                    TextFormField(
                      controller: _descricaoController,
                      decoration: InputDecoration(
                        labelText: 'Descrição*',
                        hintText: 'Digite a descrição do produto',
                        labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Faz o texto flutuar acima
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a descrição do produto.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Preço
                    TextFormField(
                      controller: _precoController,
                      decoration: InputDecoration(
                        labelText: 'Preço*',
                        hintText: 'Digite o preço do produto',
                        labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Faz o texto flutuar acima
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o preço do produto.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Estoque
                    TextFormField(
                      controller: _estoqueController,
                      decoration: InputDecoration(
                        labelText: 'Estoque*',
                        hintText: 'Digite a quantidade em estoque',
                        labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Faz o texto flutuar acima
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o estoque do produto.';
                        }
                        return null;
                      },
                    ),
                    Spacer(), // Esse espaço puxa os botões para baixo
                    // Botões de Salvar e Cancelar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Voltar para a tela anterior
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.white), // Cor do texto dos botões
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey, // Usando 'backgroundColor' em vez de 'primary'
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Cria um novo item
                              final item = Item(
                                itemId: null, // Ou outro id se necessário
                                descricao: _descricaoController.text,
                                preco: double.parse(_precoController.text),
                                estoque: int.parse(_estoqueController.text),
                                categoriaId: int.parse(_categoriaController.text), // A categoria deve ser passada
                              );

                              try {
                                // Comente a linha abaixo para testar o front-end sem o Supabase
                                // await itemService.add(item); 
                                print('Item salvo localmente: ${item.descricao}, ${item.preco}, ${item.estoque}, ${item.categoriaId}');

                                // Exibe uma mensagem de sucesso, sem usar Supabase
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Item salvo localmente!")),
                                );
                                Navigator.pop(context); // Volta para a tela anterior
                              } catch (e) {
                                // Exibe uma mensagem de erro, caso ocorra
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Erro ao salvar item: $e")),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white), // Cor do texto dos botões
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Usando 'backgroundColor' em vez de 'primary'
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
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
}
