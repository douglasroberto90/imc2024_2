import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  String _informacoes = "Insira os dados e clique em calcular";
  GlobalKey<FormState> _chaveFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _chaveFormulario,
          child: Column(
            children: [
              const Icon(
                Icons.person,
                size: 200,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerPeso,
                  decoration: const InputDecoration(label: Text("Peso(kg)")),
                  validator: (String? valor) {
                    if (valor == null || valor.isEmpty) {
                      return "Insira seu Peso!";
                    }
                    if (valor.contains(",")) {
                      return "Insira o valor decimal usando ponto";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerAltura,
                  decoration: const InputDecoration(label: Text("Altura(m)")),
                  validator: (String? valor) {
                    if (valor == null || valor.isEmpty) {
                      return "Insira seu Altura!";
                    }
                    if (valor.contains(",")) {
                      return "Insira o valor decimal usando ponto";
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_chaveFormulario.currentState!.validate()) {
                      _calcularIMC();
                      _chaveFormulario.currentState!.reset();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  ),
                  child: const Text(
                    "Calcular",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )),
              Container(
                height: 30,
              ),
              Text(
                _informacoes,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calcularIMC() {
    double peso = double.parse(controllerPeso.text);
    double altura = double.parse(controllerAltura.text);
    double imc = peso / (altura * altura);
    setState(() {
      if (imc < 18.6) {
        _informacoes = "Abaixo do peso";
      } else if (imc < 25) {
        _informacoes = "Peso ideal";
      } else if (imc < 30) {
        _informacoes = "Acima do peso";
      } else if (imc < 35) {
        _informacoes = "Obesidade grau I";
      } else if (imc < 40) {
        _informacoes = "Obesidade grau II";
      } else {
        _informacoes = "Obesidade grau III";
      }
    });
  }
}
