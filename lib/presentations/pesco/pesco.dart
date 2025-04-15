import 'package:flutter/material.dart';


class PescoScreen extends StatelessWidget {
  const PescoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesco'),),
      body: Column(
        children: [
          Text('PESCO')
        ],
      ),
    );
  }
}
