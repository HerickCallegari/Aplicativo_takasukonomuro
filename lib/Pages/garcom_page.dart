import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/mesaService.dart';
import 'package:takasukonomuro/models/enums/status.dart';
import 'package:takasukonomuro/models/mesa.dart';

class GarcomPage extends StatefulWidget {
  @override
  _GarcomPage createState() => _GarcomPage();
}

class _GarcomPage extends State<GarcomPage> {
  final MesaService mesaService = MesaService();
  List<Mesa> mesas = [];

  @override
  void initState() {
    super.initState();
    _CarregarDados();
  }

  void _CarregarDados() async {
    mesas = await mesaService.findAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kaleb')),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: mesas.length,
        itemBuilder: (context, index) {
          return MesaCard(mesa: mesas[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class MesaCard extends StatelessWidget {
  final Mesa mesa;

  MesaCard({required this.mesa});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GarcomPage()));*/
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor:
                  mesa.status == Status.Ocupado ? Colors.red : Colors.green,
              child: Icon(Icons.table_restaurant, color: Colors.black),
              radius: 30,
            ),
            SizedBox(height: 8),
            Text(mesa.descricao, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
