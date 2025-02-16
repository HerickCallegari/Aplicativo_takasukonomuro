import 'package:flutter/material.dart';
import 'package:takasukonomuro/Pages/GerentePages/formulario_itens_page.dart';
import 'package:takasukonomuro/business/services/itemService.dart';
import 'package:takasukonomuro/models/item.dart'; // Caminho correto para a tela de Formulário

class CrudItensPage extends StatefulWidget {
  @override
  _CrudItensPageState createState() => _CrudItensPageState();
}

class _CrudItensPageState extends State<CrudItensPage> {
  final ItemService service = ItemService();
  // Lista de produtos para exibir
  List<Item> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<Item> loadedItems = await service.findAll();
      setState(() {
        items = loadedItems;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Erro ao carregar itens: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors
          .transparent, // Fundo transparente para que a imagem seja visível
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
                    Navigator.pop(context); // Volta para a tela anterior
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
                    'Itens', // Alterado para "Itens"
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/teste.png'), // Caminho para a imagem de fundo
            fit: BoxFit.cover, // Faz com que a imagem cubra toda a tela
            alignment: Alignment.center, // Centraliza a imagem
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Removido o texto "Lista Itens"
              SizedBox(height: 20),
              // Usando shrinkWrap no ListView para corrigir o erro
              ListView.builder(
                shrinkWrap: true, // Impede o erro do Expanded
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(items[index]);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Redireciona para a tela de Formulário de Itens
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormularioItensPage()),
            );
          },
          label: Text(
            'Adicionar Item', // Mensagem dentro do botão
            style: TextStyle(color: Colors.white), // Texto branco
          ),
          icon: Icon(Icons.add, color: Colors.white), // Ícone branco
          backgroundColor: Colors.black,
        ),
      ),
    );
  }

  Widget _buildItemCard(Item item) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(item.descricao),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('R\$ ${item.preco.toStringAsFixed(2)}'),
            Text('Quantidade: ${item.estoque}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                // Lógica para editar o item
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioItensPage(
                        item:
                            item), // Aqui está correto, nao sei porque ele esta reclamando
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ItemService itemservice = ItemService();
                itemservice.remove(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
