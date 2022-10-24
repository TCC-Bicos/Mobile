import 'package:flutter/material.dart';

class ConfigsScreen extends StatelessWidget {
  const ConfigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 253, 255),
        title: Text(
          'Configurações',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 1,
      ),
    );
  }
}
