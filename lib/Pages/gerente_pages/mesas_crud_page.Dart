import 'package:flutter/material.dart';
import 'package:takasukonomuro/models/mesa.dart';
import 'package:takasukonomuro/pages/gerente_pages/mesas_formulario_page.dart';
import 'package:takasukonomuro/business/services/mesaService.dart';



class CrudMesasPage extends StatefulWidget {
  @override
  _CrudMesasPageState createState() => _CrudMesasPageState();
}

class _CrudMesasPageState extends State<CrudMesasPage> {
  final MesaService mesaService = MesaService();
  late Future<List<Mesa>> mesas;

  @override
  void initState() {
    super.initState();
    // Chama o método findAll do serviço para carregar as mesas ao iniciar a página
    mesas = mesaService.findAll();
  }

  // Método para buscar as mesas novamente após uma operação (adicionar ou remover)
  void _refreshMesaList() {
    setState(() {
      mesas = mesaService.findAll();
    });
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Mesas',
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
                  onPressed: _refreshMesaList, // Chama a função de atualizar a lista
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
                image: AssetImage('assets/images/mesasFundo.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Exibe as mesas ou mostra um indicador de carregamento
                  Expanded(
                    child: FutureBuilder<List<Mesa>>(
                      future: mesas,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro ao carregar as mesas.'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('Nenhuma mesa encontrada.'));
                        } else {
                          List<Mesa> mesaList = snapshot.data!;
                          return ListView.builder(
                            itemCount: mesaList.length,
                            itemBuilder: (context, index) {
                              return _buildMesaCard(mesaList[index]);
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
            bottom: MediaQuery.of(context).size.height * 0.21,
            left: MediaQuery.of(context).size.width * 0.28,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormularioMesasPage()),
                ).then((value) {
                  // Após o retorno do formulário, atualiza a lista de mesas
                  _refreshMesaList();
                });
              },
              label: Text(
                'Adicionar Mesa',
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

  Widget _buildMesaCard(Mesa mesa) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.table_bar, color: Colors.black),
        ),
        title: Text(mesa.descricao),
        subtitle: Text(mesa.getStatus().toString().split('.').last),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                // Navega para o formulário de edição, passando os dados da mesa
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioMesasPage(mesa: mesa),
                  ),
                ).then((value) {
                  // Após a edição, atualiza a lista de mesas
                  _refreshMesaList();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                // Exclui a mesa
                try {
                  await mesaService.remove(mesa);
                  // Atualiza a lista após remoção
                  _refreshMesaList();
                } catch (e) {
                  // Em caso de erro, exibe um alerta
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao excluir a mesa.')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
