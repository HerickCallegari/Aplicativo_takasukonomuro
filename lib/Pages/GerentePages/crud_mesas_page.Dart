import 'package:flutter/material.dart';
import 'package:takasukonomuro/Pages/GerentePages/formulario_mesas_page.dart';

class CrudMesasPage extends StatefulWidget {
  @override
  _CrudMesasPageState createState() => _CrudMesasPageState();
}

class _CrudMesasPageState extends State<CrudMesasPage> {
  final List<Map<String, String>> mesas = [
    {'nome': 'Mesa 1', 'status': 'Disponível'},
    {'nome': 'Mesa 2', 'status': 'Disponível'},
    {'nome': 'Mesa 3', 'status': 'Disponível'},
    {'nome': 'Mesa 4', 'status': 'Disponível'},
    {'nome': 'Mesa 5', 'status': 'Disponível'},
  ];

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
                  Expanded(
                    child: ListView.builder(
                      itemCount: mesas.length,
                      itemBuilder: (context, index) {
                        return _buildMesaCard(mesas[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.30,
            left: MediaQuery.of(context).size.width * 0.28,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormularioMesasPage()),
                );
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

  Widget _buildMesaCard(Map<String, String> mesa) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.table_bar, color: Colors.black),
        ),
        title: Text(mesa['nome']!),
        subtitle: Text(mesa['status']!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
