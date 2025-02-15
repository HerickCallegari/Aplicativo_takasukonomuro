import 'package:flutter/material.dart';
import 'package:takasukonomuro/Pages/login_page.dart';
import 'package:takasukonomuro/Pages/GerentePages/crud_itens_page.dart';
import 'package:takasukonomuro/Pages/GerentePages/crud_funcionarios_page.dart';
import 'package:takasukonomuro/Pages/GerentePages/crud_mesas_page.dart';
import 'package:takasukonomuro/Pages/GerentePages/resumo_dia_page.dart';

class GerentePage extends StatefulWidget {
  @override
  _GerentePageState createState() => _GerentePageState();
}

class _GerentePageState extends State<GerentePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Cor do fundo conforme especificado
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Ajuste do tamanho da AppBar
        child: Container(
          color: Colors.white, // Cor de fundo da AppBar
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Navegar de volta para a LoginPage
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 16), // Espaço entre o ícone de voltar e o nome
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Cor de fundo do nome
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Marcia',
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
            Text('Visão Geral', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard(Icons.people, 'Funcionários', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CrudFuncionariosPage()), // Navegação para CrudFuncionariosPage
                  );
                }),
                _buildCard(Icons.table_bar, 'Mesas'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard(
                  Icons.food_bank, 
                  'Produtos', 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CrudItensPage()), // Navegação para CrudItemsPage
                    );
                  }
                ),
                _buildCard(
                  Icons.monetization_on, 
                  'Vendas do dia', 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResumoDiaPage()), // Navegação para ResumoDiaPage
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCard(IconData icon, String label, {Function()? onTap}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.red),
              SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
