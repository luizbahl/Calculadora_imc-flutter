import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculaImc extends StatefulWidget {
  const CalculaImc({Key? key}) : super(key: key);

  @override
  State<CalculaImc> createState() => _CalculaImcState();
}

class _CalculaImcState extends State<CalculaImc> {
  var pesoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");

  double peso = 0;
  double altura = 0;
  double imc = 0;

  String calcularNivelIMC(double imc) {
    if (imc < 18.5) {
      return "Abaixo do Peso";
    } else if (imc >= 18.5 && imc <= 24.9) {
      return "Peso Normal";
    } else if (imc >= 25.0 && imc <= 29.9) {
      return "Sobrepeso";
    } else if (imc >= 30.0 && imc <= 34.9) {
      return "Obesidade Grau I";
    } else if (imc >= 35.0 && imc <= 39.9) {
      return "Obesidade Grau II";
    } else {
      return "Obesidade Grau III";
    }
  }

  void calculadoraIMC() {
    if (altura > 0 && peso > 0) {
      setState(() {
        imc = peso / (altura * altura);
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
                  onPressed: calculadoraIMC,
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
                  'Seu IMC é: ${imc.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                Text(
                  calcularNivelIMC(imc),
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
