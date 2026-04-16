import 'package:flutter/material.dart';

class TelaConfirmacao extends StatelessWidget {
  final String nome;
  final String email;
  final String idade;
  final String sexo;
  final bool aceitar;

  // O construtor recebe os dados da primeira tela
  const TelaConfirmacao(
      {super.key,
        required this.nome,
        required this.email,
        required this.idade,
        required this.sexo,
        required this.aceitar}
      );

  String Aceitou(){
    if(aceitar){
      return "sim";
    }
    return "nao";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmação")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            Text("Parabéns", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("usuario cadastrado $nome!", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Dados do cadastro novo:"),
            Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(email, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(idade, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sexo, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("aceitou os termos: ${Aceitou()}",  style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Volta para a tela anterior
              child: const Text("Editar"),
            ),
          ],
        ),
      ),
    );
  }
}