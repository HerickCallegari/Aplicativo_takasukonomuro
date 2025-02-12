import 'package:flutter/material.dart';

class GarcomPage extends StatelessWidget {
  const GarcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesas Disponíveis'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            title: Text('Mesa 4'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 31'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 20'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 4'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 31'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 20'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 4'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 31'),
            tileColor: Colors.grey,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Mesa 20'),
            tileColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}