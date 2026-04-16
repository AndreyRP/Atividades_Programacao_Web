import 'package:flutter/material.dart';
import 'confirmacao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CADASTRO DE PESSOA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Cadastro de Usuario'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? valorSelecionado;
  bool checkbox = false;

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void validarCadastro() {
    final String nome = nomeController.text.trim();
    final String idade = idadeController.text.trim();
    final String email = emailController.text.trim();

    if (nome.isEmpty) {
      mostrarMensagem("Insira um nome");
      return;
    }

    try {
      final int idadeFor = int.parse(idade);
      if (idadeFor < 18) {
        mostrarMensagem("Menor de idade");
        return;
      }
    } catch (e) {
      mostrarMensagem("Idade inválida, digite uma correta");
      return;
    }

    if (email.isEmpty || !email.contains("@") || !email.contains(".")) {
      mostrarMensagem("Email inválido, digite um correto");
      return;
    }

    if (!checkbox) {
      mostrarMensagem("Você deve aceitar os termos");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaConfirmacao(
          nome: nomeController.text,
          email: emailController.text,
          idade: idadeController.text,
          sexo: valorSelecionado!,
          aceitar: checkbox,
        ),
      ),
    );

    // All good
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cadastro realizado com sucesso"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Digite seus Dados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nomeController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Digite seu Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: idadeController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite sua Idade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration:  InputDecoration(
                labelText: 'Digite seu Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Selecione uma opção'),
              value: valorSelecionado,
              items: ['Masculino', 'Feminino', 'Outro']
                  .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  valorSelecionado = value;
                });
              },
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Aceito os termos'),
              value: checkbox,
              onChanged: (bool? value) {
                setState(() {
                  checkbox = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validarCadastro,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}





