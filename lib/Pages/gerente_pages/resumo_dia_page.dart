import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/comandaService.dart';
import 'package:takasukonomuro/business/services/mesaService.dart';
import 'package:takasukonomuro/models/comanda.dart';
import 'package:takasukonomuro/models/enums/status.dart';
import 'package:takasukonomuro/models/mesa.dart';

class ResumoDiaPage extends StatefulWidget {
  ResumoDiaPage({super.key, required this.data});

  final DateTime data;

  @override
  State<ResumoDiaPage> createState() => _ResumoDiaPageState();
}

class _ResumoDiaPageState extends State<ResumoDiaPage> {
  final ComandaService serviceComanda = ComandaService();
  final MesaService serviceMesa = MesaService();
  List<Comanda> comandas = [];
  List<Mesa> mesas = [];
  int qtClientes = 0;
  double valorTotalComandas = 0;
  int quantidadeFuncionarios = 0;

  @override
  void initState() {
    super.initState();
    _CarregarInformacoes();
  }

  void _CarregarInformacoes() async {
    comandas = await serviceComanda.findByDate(widget.data);
    mesas = await serviceMesa.findAll();
    for (Comanda comanda in comandas) {
      qtClientes += comanda.quantidadePessoas;
      valorTotalComandas += comanda.valorTotal;
    }
    quantidadeFuncionarios = comandas.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> comandasFormatadas = [];

    for (Comanda comanda in comandas) {
      Mesa? mesa = mesas?.firstWhere(
        (Mesa x) => x.mesaId == comanda.mesaId,
        orElse: () => Mesa(
            mesaId: -1,
            descricao: "Desconhecida",
            status: Status.Livre), // Evita erro de null
      );

      Map<String, String> comandaFormatada = {
        'Mesa': mesa!.descricao, // Primeiro o nome da mesa
        'Valor Total': 'R\$ ${comanda.valorTotal}', // Depois o valor total
        'Pago': comanda.pago == true ? 'Pago' : 'Aberto'
      };

      comandasFormatadas.add(comandaFormatada);
    }

    final List<Widget> orderList = comandasFormatadas.map((comandaFormatada) {
      return _buildOrderCard(comandaFormatada['Mesa']!,
          comandaFormatada['Valor Total']!, comandaFormatada['Pago']!);
    }).toList();
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: null,
        title: const Text(
          'Marcia',
          style: TextStyle(
            fontFamily: 'PlayFairDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                'M',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Visão Geral',
                  style: TextStyle(
                    fontFamily: 'PlayFairDisplay',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: _height * 0.22,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDashboardCard(
                              icon: Icons.inventory,
                              title: 'QT. Clientes',
                              value: qtClientes.toString(),
                              heigth: _height * 0.1,
                              width: _width * 0.44),
                          _buildDashboardCard(
                              icon: Icons.attach_money,
                              title: 'Vendas do dia',
                              value: 'R\$ ${valorTotalComandas}',
                              width: _width * 0.44,
                              heigth: _height * 0.1),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDashboardCard(
                              icon: Icons.people,
                              title: 'Funcionários',
                              value: quantidadeFuncionarios.toString(),
                              width: _width * 0.44,
                              heigth: _height * 0.1),
                          _buildDashboardCard(
                              icon: Icons.inventory_2,
                              title: 'QT. Comandas',
                              value: comandas.length.toString(),
                              width: _width * 0.44,
                              heigth: _height * 0.1),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pedidos Recebidos',
                  style: TextStyle(
                    fontFamily: 'PlayFairDisplay',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: orderList),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
        onTap: null,
      ),
    );
  }

  Widget _buildDashboardCard(
      {required IconData icon,
      required String title,
      required String value,
      required double width,
      required double heigth}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: heigth,
      width: width,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.red),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'PlayFairDisplay',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'PlayFairDisplay',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(String table, String value, String pago) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.add, color: Colors.black),
                const SizedBox(width: 10),
                Text(
                  table,
                  style: const TextStyle(
                    fontFamily: 'PlayFairDisplay',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              pago,
              style: const TextStyle(
                fontFamily: 'PlayFairDisplay',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'PlayFairDisplay',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
