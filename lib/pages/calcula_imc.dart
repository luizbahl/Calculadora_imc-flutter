import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculaImc extends StatefulWidget {
  const CalculaImc({Key? key}) : super(key: key);

  @override
  State<CalculaImc> createState() => _CalculaImcState();
}

class _CalculaImcState extends State<CalculaImc> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = "";
  String grauObesidade = "";

  void calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    if (peso > 0 && altura > 0) {
      double imc = peso / (altura * altura);
      setState(() {
        resultado = "Seu IMC é ${imc.toStringAsFixed(2)}";

        if (imc < 18.5) {
          grauObesidade = "Abaixo do Peso";
        } else if (imc >= 18.5 && imc <= 25) {
          grauObesidade = "Peso Normal";
        } else if (imc > 25.0 && imc <= 30) {
          grauObesidade = "Sobrepeso";
        } else if (imc > 30.0 && imc <= 35) {
          grauObesidade = "Obesidade Grau I";
        } else if (imc > 35.0 && imc <= 39.9) {
          grauObesidade = "Obesidade Grau II";
        } else {
          grauObesidade = "Obesidade Grau III";
        }
      });
    } else {
      setState(() {
        resultado = "Por favor, insira valores válidos.";
        grauObesidade = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 245, 240, 225),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextField(
                  style: GoogleFonts.amita(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: pesoController, // arrumar adicionar variável
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 2, top: 13),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      hintText: "Peso",
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                      prefixIcon: Icon(
                        Icons.balance,
                        color: Colors.black,
                        size: 35,
                      )),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextField(
                  style: GoogleFonts.amita(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: alturaController, // arrumar adicionar variável
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 2, top: 13),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      hintText: "Altura em metros",
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                      prefixIcon: Icon(
                        Icons.height,
                        color: Colors.black,
                        size: 40,
                      )),
                ),
                const SizedBox(height: 80),
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 209, 209, 209))),
                  onPressed: () {
                    calcularIMC();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Text(
                    'Calcular IMC',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  resultado,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                Text(
                  grauObesidade,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
