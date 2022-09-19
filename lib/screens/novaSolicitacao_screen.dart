import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NovaSolicitacao extends StatefulWidget {
  const NovaSolicitacao({Key? key}) : super(key: key);

  @override
  State<NovaSolicitacao> createState() => _NovaSolicitacaoState();
}

class _NovaSolicitacaoState extends State<NovaSolicitacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 253, 255),
        title: Image.asset(
          'assets/images/bicoslogo_azul.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
    );
  }
}
