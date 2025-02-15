import 'package:flutter/material.dart';

class ResumoDiaPage extends StatefulWidget {
  const ResumoDiaPage({super.key});

  @override
  State<ResumoDiaPage> createState() => _ResumoDiaPageState();
}

class _ResumoDiaPageState extends State<ResumoDiaPage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> orderList = [
      _buildOrderCard('Mesa 26', 'R\$ 12,90'),
      _buildOrderCard('Mesa 30', 'R\$ 1239,00'),
      _buildOrderCard('Mesa 4', 'R\$ 230,90'),
      _buildOrderCard('Mesa 5', 'R\$ 45,89'),
      for (int i = 0; i < 15; i++) _buildOrderCard('Mesa 5', 'R\$ 45,89'),
    ];
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
                              title: 'Pedidos',
                              value: '129',
                              heigth: _height * 0.1,
                              width: _width * 0.44),
                          _buildDashboardCard(
                              icon: Icons.attach_money,
                              title: 'Vendas do dia',
                              value: 'R\$ 1.000,89',
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
                              value: '20',
                              width: _width * 0.44,
                              heigth: _height * 0.1),
                          _buildDashboardCard(
                              icon: Icons.inventory_2,
                              title: 'Estoque',
                              value: '96%',
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

  Widget _buildOrderCard(String table, String value) {
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
